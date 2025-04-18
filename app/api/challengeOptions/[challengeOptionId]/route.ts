// app/api/challenges/[challengeId]/route.ts

import { NextResponse } from "next/server";
import db from "@/db/drizzle";
import { challenges } from "@/db/schema";
import { eq } from "drizzle-orm";
import { isAdmin } from "@/lib/admin";

// Use inferred Next.js context without forcing ParamCheck conflict
type Context = {
  params: {
    challengeId: string;
  };
};

export async function GET(_req: Request, { params }: Context) {
  const id = parseInt(params.challengeId, 10);

  if (isNaN(id)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const data = await db.query.challenges.findFirst({
    where: eq(challenges.id, id),
  });

  return NextResponse.json(data);
}
