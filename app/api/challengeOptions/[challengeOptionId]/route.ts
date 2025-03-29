import db from "@/db/drizzle";
import { challengeOptions } from "@/db/schema";
import { isAdmin } from "@/lib/admin";
import { eq } from "drizzle-orm";
import { NextResponse } from "next/server";

export const GET = async (
  req: Request,
  context: { params: { challengeOptionId: string } }
) => {
  const params = await context.params; // Explicitly await params

  const challengeOptionId = parseInt(params.challengeOptionId, 10);

  if (isNaN(challengeOptionId)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const data = await db.query.challengeOptions.findFirst({
    where: eq(challengeOptions.id, challengeOptionId),
  });

  return NextResponse.json(data);
};


export const PUT = async (
  req: Request,
  context: { params: { challengeOptionId: string } }
) => {
  const params = await context.params;

  const challengeOptionId = parseInt(params.challengeOptionId, 10);

  if (isNaN(challengeOptionId)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const body = await req.json();
  const data = await db.update(challengeOptions)
    .set({ ...body })
    .where(eq(challengeOptions.id, challengeOptionId))
    .returning();

  return NextResponse.json(data[0]);
};


export const DELETE = async (
  req: Request,
  context: { params: { challengeOptionId: string } }
) => {
  const params = await context.params;

  const challengeOptionId = parseInt(params.challengeOptionId, 10);

  if (isNaN(challengeOptionId)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const data = await db.delete(challengeOptions)
    .where(eq(challengeOptions.id, challengeOptionId))
    .returning();

  return NextResponse.json(data[0]);
};






