"use server";

import { auth } from "@clerk/nextjs/server";
import { stripe } from "@/lib/stripe";
import { userSubscription } from "@/db/schema";
import { eq } from "drizzle-orm";
import { revalidatePath } from "next/cache";
import db from "@/db/drizzle";

export const createStripeUrl = async () => {
  try {
    const { userId } = await auth();
    if (!userId) throw new Error("Unauthorized");

    // Check if user has a subscription
    const userSub = await db.query.userSubscription.findFirst({
      where: eq(userSubscription.userId, userId),
    });

    // Create portal session for existing customers
    if (userSub?.stripeCustomerId) {
      const portalSession = await stripe.billingPortal.sessions.create({
        customer: userSub.stripeCustomerId,
        return_url: `${process.env.NEXT_PUBLIC_APP_URL}/shop`,
      });
      return { data: portalSession.url };
    }

    // Create checkout session for new customers
    const checkoutSession = await stripe.checkout.sessions.create({
        mode: "subscription",
        payment_method_types: ["card"],
        line_items: [
          {
            price_data: {
              currency: "inr", // ✅ INR here
              unit_amount: 49900, // ₹499.00 → Stripe requires amount in paise
              product_data: {
                name: "Pro Plan",
              },
              recurring: {
                interval: "month",
              },
            },
            quantity: 1,
          },
        ],
        metadata: {
          userId,
        },
        success_url: `${process.env.NEXT_PUBLIC_APP_URL}/shop?success=true`,
        cancel_url: `${process.env.NEXT_PUBLIC_APP_URL}/shop?canceled=true`,
      });
      

    return { data: checkoutSession.url };
  } catch (error) {
    console.error("Stripe error:", error);
    return { error: "Failed to create Stripe session" };
  }
};