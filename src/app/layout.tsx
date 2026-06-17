import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });

export const metadata: Metadata = {
  title: "Annuaire Agirc-Arrco",
  description: "Gestion des mandats et de la gouvernance paritaire",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="fr" className={`${inter.variable} h-full`}>
      <body className="h-full font-sans bg-bg text-ink">{children}</body>
    </html>
  );
}
