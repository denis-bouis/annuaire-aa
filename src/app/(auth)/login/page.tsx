"use client";

import { useState, Suspense } from "react";
import { useRouter, useSearchParams } from "next/navigation";

function LoginForm() {
  const router = useRouter();
  const params = useSearchParams();
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setError("");

    const res = await fetch("/api/auth/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ password }),
    });

    if (res.ok) {
      router.push(params.get("from") ?? "/instances");
    } else {
      const { error: msg } = await res.json();
      setError(msg ?? "Erreur");
      setLoading(false);
    }
  }

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-4">
      <input
        type="password"
        placeholder="Mot de passe"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        autoFocus
        className="border border-border rounded px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-blue/40"
      />
      {error && <p className="text-red text-sm">{error}</p>}
      <button
        type="submit"
        disabled={loading || !password}
        className="bg-blue text-white rounded px-4 py-2 text-sm font-medium hover:bg-blue/90 disabled:opacity-50 transition-colors"
      >
        {loading ? "Connexion…" : "Accéder"}
      </button>
    </form>
  );
}

export default function LoginPage() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-bg">
      <div className="bg-surface border border-border rounded-xl p-8 w-full max-w-sm shadow-sm">
        <h1 className="text-xl font-semibold mb-1">Annuaire Agirc-Arrco</h1>
        <p className="text-muted text-sm mb-6">Accès restreint</p>
        <Suspense>
          <LoginForm />
        </Suspense>
      </div>
    </div>
  );
}
