import db from "@/db/drizzle";
import { units } from "@/db/schema";
import { isAdmin } from "@/lib/admin";
import { eq } from "drizzle-orm";
import { NextResponse } from "next/server";

export const GET = async (
  req: Request,
  context: { params: { unitId: string } }
) => {
  const { params } = context;
  const unitId = parseInt(params.unitId, 10);

  if (isNaN(unitId)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const data = await db.query.units.findFirst({
    where: eq(units.id, unitId),
  });

  return NextResponse.json(data);
};


export const PUT = async (
  req: Request,
  context: { params: { unitId: string } }
) => {
  const { params } = context;
  const unitId = parseInt(params.unitId, 10);

  if (isNaN(unitId)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const body = await req.json();
  const data = await db.update(units)
    .set({ ...body })
    .where(eq(units.id, unitId))
    .returning();

  return NextResponse.json(data[0]);
};


export const DELETE = async (
  req: Request,
  context: { params: { unitId: string } }
) => {
  const { params } = context;
  const unitId = parseInt(params.unitId, 10);

  if (isNaN(unitId)) {
    return new NextResponse("Invalid ID", { status: 400 });
  }

  if (!isAdmin()) {
    return new NextResponse("Unauthorized", { status: 403 });
  }

  const data = await db.delete(units)
    .where(eq(units.id, unitId))
    .returning();

  return NextResponse.json(data[0]);
};




