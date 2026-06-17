"use client";

import { useRef, useState, useTransition } from "react";
import { updatePersonne } from "./actions";
import type { Personne } from "@/types/database";

function EditDialog({
  person,
  onClose,
}: {
  person: Personne;
  onClose: () => void;
}) {
  const [isPending, startTransition] = useTransition();
  const [error, setError] = useState<string | null>(null);

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const fd = new FormData(e.currentTarget);
    const nom       = (fd.get("nom")       as string).trim();
    const prenom    = (fd.get("prenom")    as string).trim();
    const honorific = (fd.get("honorific") as string).trim() || null;
    if (!nom || !prenom) return;
    setError(null);
    startTransition(async () => {
      try {
        await updatePersonne(person.id, { nom, prenom, honorific });
        onClose();
      } catch (err) {
        setError(err instanceof Error ? err.message : "Erreur inconnue");
      }
    });
  }

  return (
    <form key={person.id} onSubmit={handleSubmit} className="flex flex-col gap-4">
      <div className="flex items-center justify-between mb-2">
        <h2 className="text-base font-semibold">Modifier la personne</h2>
        <button
          type="button"
          onClick={onClose}
          className="text-muted hover:text-ink text-xl leading-none"
          aria-label="Fermer"
        >
          ×
        </button>
      </div>

      <label className="flex flex-col gap-1 text-sm">
        <span className="text-muted font-medium">Nom</span>
        <input
          name="nom"
          required
          defaultValue={person.nom}
          className="border border-border rounded px-3 py-2 text-sm bg-surface focus:outline-none focus:ring-1 focus:ring-blue"
        />
      </label>

      <label className="flex flex-col gap-1 text-sm">
        <span className="text-muted font-medium">Prénom</span>
        <input
          name="prenom"
          required
          defaultValue={person.prenom}
          className="border border-border rounded px-3 py-2 text-sm bg-surface focus:outline-none focus:ring-1 focus:ring-blue"
        />
      </label>

      <label className="flex flex-col gap-1 text-sm">
        <span className="text-muted font-medium">
          Honorifique{" "}
          <span className="font-normal text-muted">(optionnel)</span>
        </span>
        <input
          name="honorific"
          defaultValue={person.honorific ?? ""}
          placeholder="M., Mme, Dr…"
          className="border border-border rounded px-3 py-2 text-sm bg-surface focus:outline-none focus:ring-1 focus:ring-blue"
        />
      </label>

      {error && (
        <p className="text-red text-xs bg-red-bg rounded px-3 py-2">{error}</p>
      )}

      <div className="flex justify-end gap-3 pt-2">
        <button
          type="button"
          onClick={onClose}
          className="px-4 py-2 text-sm rounded border border-border hover:bg-surface transition-colors"
        >
          Annuler
        </button>
        <button
          type="submit"
          disabled={isPending}
          className="px-4 py-2 text-sm rounded bg-blue text-white hover:opacity-90 transition-opacity disabled:opacity-50"
        >
          {isPending ? "Enregistrement…" : "Enregistrer"}
        </button>
      </div>
    </form>
  );
}

export function PersonnesRows({ personnes }: { personnes: Personne[] }) {
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [editing, setEditing] = useState<Personne | null>(null);

  function openEdit(p: Personne) {
    setEditing(p);
    dialogRef.current?.showModal();
  }

  function closeDialog() {
    dialogRef.current?.close();
    setEditing(null);
  }

  return (
    <>
      <tbody>
        {personnes.length === 0 ? (
          <tr>
            <td colSpan={4} className="py-8 text-center text-muted">
              Aucune personne ne correspond à la recherche.
            </td>
          </tr>
        ) : (
          personnes.map((p) => (
            <tr
              key={p.id}
              className="border-b border-border hover:bg-blue-bg/40 transition-colors group"
            >
              <td className="py-2 pr-8 font-medium">{p.nom}</td>
              <td className="py-2 pr-8">{p.prenom}</td>
              <td className="py-2 pr-8 text-muted text-xs">{p.honorific ?? ""}</td>
              <td className="py-2 text-right">
                <button
                  onClick={() => openEdit(p)}
                  className="text-xs text-muted hover:text-blue opacity-0 group-hover:opacity-100 transition-opacity px-2 py-1 rounded hover:bg-blue-bg"
                >
                  Modifier
                </button>
              </td>
            </tr>
          ))
        )}
      </tbody>

      <dialog
        ref={dialogRef}
        onClick={(e) => {
          if (e.target === e.currentTarget) closeDialog();
        }}
        className="rounded-xl border border-border bg-surface shadow-lg p-6 w-full max-w-md backdrop:bg-black/40 backdrop:backdrop-blur-sm"
      >
        {editing && <EditDialog person={editing} onClose={closeDialog} />}
      </dialog>
    </>
  );
}
