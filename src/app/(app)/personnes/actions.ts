"use server";

import { createClient } from "@/lib/supabase/client";
import { revalidatePath } from "next/cache";

export async function updatePersonne(
  id: string,
  data: { nom: string; prenom: string; honorific: string | null }
) {
  const db = createClient();
  const { error } = await db.from("personnes").update(data).eq("id", id);
  if (error) throw new Error(error.message);
  revalidatePath("/personnes");
}
