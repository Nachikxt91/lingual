import db from "@/db/drizzle";
import { challenges } from "@/db/schema";
import { isAdmin } from "@/lib/admin";
import { eq } from "drizzle-orm";
import { NextResponse } from "next/server";

export const GET = async (
  req: Request,
  context: { params: { challengeId: string } }
) => {
  const { params } = context; // No need to `await` context, just destructure properly
  const challengeId = parseInt(params.challengeId, 10);

  if (isNaN(challengeId)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const data = await db.query.challenges.findFirst({
    where: eq(challenges.id, challengeId),
  });

  return NextResponse.json(data);
};

export const PUT = async (
  req: Request,
  context: { params: { challengeId: string } }
) => {
  const { params } = context;
  const challengeId = parseInt(params.challengeId, 10);

  if (isNaN(challengeId)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const body = await req.json();
  const data = await db.update(challenges)
    .set({ ...body })
    .where(eq(challenges.id, challengeId))
    .returning();

  return NextResponse.json(data[0]);
};

export const DELETE = async (
  req: Request,
  context: { params: { challengeId: string } }
) => {
  const { params } = context;
  const challengeId = parseInt(params.challengeId, 10);

  if (isNaN(challengeId)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const data = await db.delete(challenges)
    .where(eq(challenges.id, challengeId))
    .returning();

  return NextResponse.json(data[0]);
};





