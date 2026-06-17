import { NextResponse } from "next/server";

export async function POST() {
  const response = NextResponse.redirect("/login");
  response.cookies.delete("aa_session");
  return response;
}
