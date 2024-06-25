-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('USER', 'ORGANIZATION', 'ADMIN', 'SUPERADMIN');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('UNVERIFIED', 'VERIFIED', 'SUSPENDED', 'DELETED');

-- CreateEnum
CREATE TYPE "Type" AS ENUM ('Organization', 'Business', 'Product');

-- CreateTable
CREATE TABLE "Category" (
    "categoryID" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "type" "Type" NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("categoryID")
);

-- CreateTable
CREATE TABLE "District" (
    "mendagriID" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "image" TEXT,

    CONSTRAINT "District_pkey" PRIMARY KEY ("mendagriID")
);

-- CreateTable
CREATE TABLE "Admin" (
    "adminID" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "DOB" DATE NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "apiKey" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "role" "UserRole" NOT NULL DEFAULT 'ADMIN',
    "status" "Status" NOT NULL DEFAULT 'UNVERIFIED',

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("adminID")
);

-- CreateTable
CREATE TABLE "User" (
    "userID" BIGSERIAL NOT NULL,
    "fullName" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "DOB" DATE NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "googleAccount" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "role" "UserRole" NOT NULL DEFAULT 'USER',
    "status" "Status" NOT NULL DEFAULT 'UNVERIFIED',

    CONSTRAINT "User_pkey" PRIMARY KEY ("userID")
);

-- CreateTable
CREATE TABLE "Organization" (
    "organizationID" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "role" "UserRole" NOT NULL DEFAULT 'ORGANIZATION',
    "district" TEXT NOT NULL,
    "regency" TEXT NOT NULL DEFAULT 'Manggarai Barat',
    "longitude" DOUBLE PRECISION NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "email" TEXT,
    "mailingAddress" TEXT NOT NULL,
    "contactNumber" TEXT NOT NULL,
    "categoryID" BIGINT NOT NULL,
    "districtID" TEXT NOT NULL,
    "userID" BIGINT NOT NULL,
    "status" "Status" NOT NULL DEFAULT 'UNVERIFIED',

    CONSTRAINT "Organization_pkey" PRIMARY KEY ("organizationID")
);

-- CreateTable
CREATE TABLE "Business" (
    "businessID" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "photo" TEXT NOT NULL,
    "description" TEXT,
    "openTime" TEXT NOT NULL,
    "closeTime" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "district" TEXT NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "email" TEXT,
    "contactNumber" TEXT NOT NULL,
    "whatsAppLink" TEXT,
    "categoryID" BIGINT NOT NULL,
    "districtID" TEXT NOT NULL,
    "ProductCategory" TEXT[],
    "organizationID" TEXT NOT NULL,
    "status" "Status" NOT NULL DEFAULT 'UNVERIFIED',

    CONSTRAINT "Business_pkey" PRIMARY KEY ("businessID")
);

-- CreateTable
CREATE TABLE "Product" (
    "productID" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "photo" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "categoryID" BIGINT NOT NULL,
    "businessID" BIGINT NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("productID")
);

-- CreateTable
CREATE TABLE "Image" (
    "imageID" BIGSERIAL NOT NULL,
    "imageURL" TEXT NOT NULL,
    "productID" BIGINT,
    "businessID" BIGINT,
    "districtID" TEXT,
    "categoryID" BIGINT,
    "organizationID" TEXT,

    CONSTRAINT "Image_pkey" PRIMARY KEY ("imageID")
);

-- CreateIndex
CREATE UNIQUE INDEX "Category_categoryID_key" ON "Category"("categoryID" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "District_mendagriID_key" ON "District"("mendagriID");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_adminID_key" ON "Admin"("adminID");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_phoneNumber_key" ON "Admin"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_apiKey_key" ON "Admin"("apiKey");

-- CreateIndex
CREATE UNIQUE INDEX "User_userID_key" ON "User"("userID");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phoneNumber_key" ON "User"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "User_googleAccount_key" ON "User"("googleAccount");

-- CreateIndex
CREATE INDEX "User_gender_status_role_idx" ON "User"("gender", "status", "role");

-- CreateIndex
CREATE UNIQUE INDEX "Organization_organizationID_key" ON "Organization"("organizationID");

-- CreateIndex
CREATE UNIQUE INDEX "Organization_userID_key" ON "Organization"("userID");

-- CreateIndex
CREATE INDEX "Organization_districtID_categoryID_status_idx" ON "Organization"("districtID", "categoryID" DESC, "status");

-- CreateIndex
CREATE UNIQUE INDEX "Business_businessID_key" ON "Business"("businessID" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "Business_organizationID_key" ON "Business"("organizationID");

-- CreateIndex
CREATE INDEX "Business_districtID_categoryID_organizationID_idx" ON "Business"("districtID", "categoryID" DESC, "organizationID");

-- CreateIndex
CREATE UNIQUE INDEX "Product_productID_key" ON "Product"("productID" ASC);

-- CreateIndex
CREATE INDEX "Product_businessID_categoryID_idx" ON "Product"("businessID", "categoryID" DESC);

-- CreateIndex
CREATE UNIQUE INDEX "Image_imageID_key" ON "Image"("imageID" ASC);

-- CreateIndex
CREATE UNIQUE INDEX "Image_imageURL_key" ON "Image"("imageURL");

-- AddForeignKey
ALTER TABLE "Organization" ADD CONSTRAINT "Organization_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("userID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Organization" ADD CONSTRAINT "Organization_categoryID_fkey" FOREIGN KEY ("categoryID") REFERENCES "Category"("categoryID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Organization" ADD CONSTRAINT "Organization_districtID_fkey" FOREIGN KEY ("districtID") REFERENCES "District"("mendagriID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Business" ADD CONSTRAINT "Business_districtID_fkey" FOREIGN KEY ("districtID") REFERENCES "District"("mendagriID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Business" ADD CONSTRAINT "Business_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES "Organization"("organizationID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Business" ADD CONSTRAINT "Business_categoryID_fkey" FOREIGN KEY ("categoryID") REFERENCES "Category"("categoryID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_categoryID_fkey" FOREIGN KEY ("categoryID") REFERENCES "Category"("categoryID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_businessID_fkey" FOREIGN KEY ("businessID") REFERENCES "Business"("businessID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_productID_fkey" FOREIGN KEY ("productID") REFERENCES "Product"("productID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_businessID_fkey" FOREIGN KEY ("businessID") REFERENCES "Business"("businessID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_districtID_fkey" FOREIGN KEY ("districtID") REFERENCES "District"("mendagriID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_categoryID_fkey" FOREIGN KEY ("categoryID") REFERENCES "Category"("categoryID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES "Organization"("organizationID") ON DELETE CASCADE ON UPDATE CASCADE;
