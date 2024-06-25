import { db } from "@/server/db";
import { Route } from "@/type/global.enum";
import { DistrictCard } from "@/component/district/district.card";

export default async function DistrictPage() {
  const district = await db.district.findMany();
  console.log(district);

  return (
    <main className="flex w-full justify-center">
      <div className="district-card-list flex w-full flex-wrap justify-between">
        {district.length > 0 ? (
          district.map((item) => {
            return (
              <DistrictCard
                key={item.mendagriID}
                imgUrl={item.image ? item.image : ""}
                title={item.name}
                url={`${Route.DISTRICT}`}
              />
            );
          })
        ) : (
          <h1>
            Data kecamatan belum ada <br></br>mohon tambahkan terlebih dahulu !
          </h1>
        )}
      </div>
    </main>
  );
}
