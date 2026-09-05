import { NextRequest, NextResponse } from "next/server";
import { getCatalogBrowseData } from "@/lib/catalog";

export async function GET(request: NextRequest) {
  const params = request.nextUrl.searchParams;
  const data = await getCatalogBrowseData({
    category: params.get("category") || undefined, brand: params.get("brand") || undefined,
    collection: params.get("collection") || undefined, material: params.get("material") || undefined,
    style: params.get("style") || undefined, color: params.get("color") || undefined,
    priceRange: params.get("priceRange") || undefined, search: params.get("search") || undefined,
    offset: Number(params.get("offset") || 0), limit: Number(params.get("limit") || 24),
  });
  return NextResponse.json(data, { headers: { "Cache-Control": "public, s-maxage=300, stale-while-revalidate=600" } });
}
