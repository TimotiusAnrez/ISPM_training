import { Navbar } from "@/component/mainNav";

import "@/styles/globals.css";

import { GeistSans } from "geist/font/sans";

export const metadata = {
  title: "Create T3 App",
  description: "Generated by create-t3-app",
  icons: [{ rel: "icon", url: "/favicon.ico" }],
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${GeistSans.variable}`} data-theme="emerald">
      <body className="flex h-screen w-screen flex-row bg-gray-50 p-8">
        <Navbar />
        <div className="content h-full w-full p-16">{children}</div>
      </body>
    </html>
  );
}
