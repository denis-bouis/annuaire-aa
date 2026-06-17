import Link from "next/link";

const nav = [
  { href: "/instances", label: "Instances" },
  { href: "/irc",       label: "IRC" },
  { href: "/personnes", label: "Personnes" },
];

export default function AppLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex h-full">
      <aside className="w-48 shrink-0 border-r border-border bg-surface flex flex-col p-4">
        <p className="text-xs font-semibold text-muted uppercase tracking-widest mb-4">
          Annuaire AA
        </p>
        <nav className="flex flex-col gap-1 flex-1">
          {nav.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="rounded px-3 py-2 text-sm text-ink hover:bg-blue-bg hover:text-blue transition-colors"
            >
              {item.label}
            </Link>
          ))}
        </nav>
        <form action="/api/auth/logout" method="POST">
          <button
            type="submit"
            className="w-full text-left rounded px-3 py-2 text-sm text-muted hover:bg-red-bg hover:text-red transition-colors"
          >
            Déconnexion
          </button>
        </form>
      </aside>
      <main className="flex-1 overflow-auto p-8">{children}</main>
    </div>
  );
}
