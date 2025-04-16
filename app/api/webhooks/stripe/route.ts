import db from "@/db/drizzle";
import { userSubscription } from "@/db/schema";
import { stripe } from "@/lib/stripe";
import { eq } from "drizzle-orm";
import { headers } from "next/headers";
import { NextResponse } from "next/server";
import Stripe from "stripe";

export async function POST(req: Request) {
  const body = await req.text();
  const signature = (await headers()).get("Stripe-Signature") as string;

  let event: Stripe.Event;

  try {
    event = stripe.webhooks.constructEvent(
      body,
      signature,
      process.env.STRIPE_WEBHOOK_SECRET!
    );
  } catch (error: any) {
    console.error(`Webhook Error: ${error.message}`);
    return new NextResponse(`Webhook Error: ${error.message}`, { status: 400 });
  }

  try {
    // Handle checkout.session.completed (new subscription)
    if (event.type === "checkout.session.completed") {
      const session = event.data.object as Stripe.Checkout.Session;
      
      if (!session.subscription) {
        console.error("No subscription ID in session");
        return new NextResponse("Subscription ID is required", { status: 400 });
      }

      const subscription = await stripe.subscriptions.retrieve(
        session.subscription as string
      );

      if (!session?.metadata?.userId) {
        console.error("No user ID in metadata");
        return new NextResponse("User ID is required", { status: 400 });
      }

      await db.insert(userSubscription).values({
        userId: session.metadata.userId,
        stripeSubscriptionId: subscription.id,
        stripeCustomerId: subscription.customer as string,
        stripePriceId: subscription.items.data[0].price.id,
        stripeCurrentPeriodEnd: new Date(
          subscription.current_period_end * 1000
        ),
      });
    }
    // Handle invoice.payment_succeeded (renewal)
    else if (event.type === "invoice.payment_succeeded") {
      const invoice = event.data.object as Stripe.Invoice;
      
      if (!invoice.subscription) {
        console.error("No subscription ID in invoice");
        return new NextResponse("Subscription ID is required", { status: 400 });
      }

      const subscription = await stripe.subscriptions.retrieve(
        invoice.subscription as string
      );

      await db.update(userSubscription)
        .set({
          stripePriceId: subscription.items.data[0].price.id,
          stripeCurrentPeriodEnd: new Date(
            subscription.current_period_end * 1000
          ),
        })
        .where(eq(userSubscription.stripeSubscriptionId, subscription.id));
    }

    return new NextResponse(null, { status: 200 });
  } catch (error: any) {
    console.error("Webhook processing error:", error);
    return new NextResponse(`Internal Error: ${error.message}`, { status: 500 });
  }
}