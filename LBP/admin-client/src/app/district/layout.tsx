import { Route } from "@/type/global.enum";
import { TopBar, BreadCrumpItem } from "@/component/topBar";

export default function Layout({ children }: { children: React.ReactNode }) {
  let list = new Array<BreadCrumpItem>(
    { id: 1, name: "beranda", url: Route.HOME },
    { id: 2, name: "kecamatan", url: Route.DISTRICT },
  );
  return (
    <main>
      <TopBar title="Manajemen Kecamatan" list={list} />

      <div className="content py-20">{children}</div>
    </main>
  );
}
