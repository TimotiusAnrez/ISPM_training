import { Route } from "@/type/global.enum";
import Link from "next/link";

export type BreadCrumpItem = {
  id: number;
  name: string;
  url: Route;
};

export type BreadCrumpList = {
  list: Array<BreadCrumpItem>;
};

export function BreadCrump({ list }: BreadCrumpList) {
  return (
    <div className="breadcrumbs text-xl">
      <ul>
        {list.map((item, index) => {
          return (
            <li key={index}>
              <Link href={item.url}>{item.name}</Link>
            </li>
          );
        })}
      </ul>
    </div>
  );
}

export type TopBarProps = {
  title: string;
  list: Array<BreadCrumpItem>;
};

export function TopBar({ title, list }: TopBarProps) {
  return (
    <div className="topBar flex w-full content-center justify-between">
      <BreadCrump list={list} />
      <h2 className="text-3xl">{title}</h2>
    </div>
  );
}
