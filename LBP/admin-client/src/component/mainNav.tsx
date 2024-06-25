import Link from "next/link";
import { LandPlot, LayoutList } from "lucide-react";
import { Route } from "@/type/global.enum";

type AvatarProps = {
  profileName: string;
};

type MenuItemProps = {
  linkRef: Route;
  label: string;
  children: React.ReactNode;
};

function Avatar({ profileName }: AvatarProps) {
  return (
    <div className="profile h-32 w-full content-center border-t-2 border-t-slate-400 p-4 transition duration-300 hover:cursor-pointer hover:rounded-md hover:border-none hover:bg-slate-300">
      <div className="profileDetail flex w-full flex-row">
        <div className="avatar placeholder">
          <div className="bg-neutral text-neutral-content w-12 rounded-full">
            <span className="text-xl">{profileName[0]}</span>
          </div>
        </div>
        <h5 className="ml-5 content-center text-xl">{profileName}</h5>
      </div>
    </div>
  );
}

function MenuItem({ linkRef, label, children }: MenuItemProps) {
  return (
    <Link
      href={linkRef}
      className="my-1 flex h-16 w-full content-center rounded-md px-2 transition duration-300 hover:bg-slate-200"
    >
      <div className="iconsvg h-full content-center">{children}</div>
      <button className="ml-5 text-2xl ">{label}</button>
    </Link>
  );
}

export function Navbar() {
  return (
    <div className="navbar flex h-full w-1/6 flex-col rounded-xl border-2 border-slate-300 bg-gray-50">
      <h2 className="text-xl">Daftar kecamatan</h2>
      <ul className="menu h-full w-full justify-end  py-4 text-base">
        <MenuItem linkRef={Route.DISTRICT} label="Kecamatan">
          <LandPlot size={"2rem"} />
        </MenuItem>
        <MenuItem linkRef={Route.CATEGORY} label="Kategori">
          <LayoutList size={"2rem"} />
        </MenuItem>
      </ul>
      <Avatar profileName="John Doe" />
    </div>
  );
}
