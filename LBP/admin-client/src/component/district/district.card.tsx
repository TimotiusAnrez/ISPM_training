import Link from "next/link";
import { Suspense } from "react";

type CardProps = {
  imgUrl: string;
  url: string;
  title: string;
};

function CardSkeleton() {
  return <div className="skeleton w-1/6"></div>;
}

export function DistrictCard({ imgUrl, url, title }: CardProps) {
  return (
    <Suspense fallback="No data found">
      {!title ? (
        <CardSkeleton />
      ) : (
        <Link href={url}>
          <div className="card image-full mx-2 my-4 w-1/6 shadow-xl">
            <figure>
              <img src={imgUrl} alt={title} />
            </figure>
            <div className="card-body flex h-full flex-col-reverse">
              <h2 className="card-title">{title}</h2>
            </div>
          </div>
        </Link>
      )}
    </Suspense>
  );
}
