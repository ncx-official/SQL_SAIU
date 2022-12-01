CREATE TABLE `Country`(
    `id_country` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `countryValue` VARCHAR (50) NOT NULL 
);

CREATE TABLE `Region`(
    `id_region` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_country` BIGINT NULL,
    `regionValue` VARCHAR(100) NOT NULL,

    FOREIGN KEY (`id_country`) REFERENCES `Country`(`id_country`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `City`(
    `id_city` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_region` BIGINT NOT NULL,
    `cityValue` VARCHAR(40) NOT NULL,

    FOREIGN KEY (`id_region`) REFERENCES `Region`(`id_region`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `Address`(
    `id_address` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_city` BIGINT NOT NULL,
    `streetValue` VARCHAR(60) NOT NULL,
    `streetNumber` VARCHAR(20) NOT NULL,

    FOREIGN KEY (`id_city`) REFERENCES `City`(`id_city`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `VehicleCategory`(
    `id_vehicleCategory` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `category_value` VARCHAR(5) NOT NULL
);

CREATE TABLE `DriverLicense`(
    `id_driverLicense` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_vehicleCategory` BIGINT NOT NULL,
    `licenseIssueDate` DATE NULL,
    `licenseExpiryDate` DATE NOT NULL,
    `licenseAuthority` VARCHAR(20) NOT NULL,
    `licenseNumber` VARCHAR(30) NOT NULL,
    `licenseBloodType` VARCHAR(40) NOT NULL,

    FOREIGN KEY (`id_vehicleCategory`) REFERENCES `VehicleCategory`(`id_vehicleCategory`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `PassportType`(
    `id_passportType` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `passportTypeValue` VARCHAR(40) NOT NULL 
);

CREATE TABLE `Passport`(
    `id_passport` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_passportType` BIGINT NOT NULL,
    `passportNumber` VARCHAR(20) NOT NULL,
    `passportIssueDate` DATE NULL,
    `passportExpiryDate` DATE NOT NULL,
    `passportAuthority` VARCHAR(15) NOT NULL,

    FOREIGN KEY (`id_passportType`) REFERENCES `PassportType`(`id_passportType`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `Sex`(
    `id_sex` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `sex_value` VARCHAR(30)
);

CREATE TABLE `Person`(
    `id_person` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_address` BIGINT NOT NULL,
    `id_driverLicense` BIGINT UNIQUE NULL,
    `id_passport` BIGINT UNIQUE NOT NULL,
    `id_sex` BIGINT NOT NULL,
    `firstName` VARCHAR(40) NOT NULL,
    `middleName` VARCHAR(40) NULL,
    `lastName` VARCHAR(40) NOT NULL,
    `birthDate` DATE NOT NULL,
    `IPN_number` VARCHAR(25) UNIQUE NOT NULL,

    FOREIGN KEY (`id_address`) REFERENCES `Address`(`id_address`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_driverLicense`) REFERENCES `DriverLicense`(`id_driverLicense`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_passport`) REFERENCES `Passport`(`id_passport`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_sex`) REFERENCES `Sex`(`id_sex`) ON DELETE RESTRICT ON UPDATE CASCADE    
);

CREATE TABLE `WeekDay`(
    `id_weekDay` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `weekDayValue` VARCHAR(30) NOT NULL
);

CREATE TABLE `ScheduleOpen`(
    `id_scheduleOpen` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_weekDay` BIGINT NOT NULL,
    `openAt` TIME,
    `closeAt` TIME,

    FOREIGN KEY (`id_weekDay`) REFERENCES `WeekDay`(`id_weekDay`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `Office`(
    `id_office` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_address` BIGINT NOT NULL,
    `id_scheduleOpen` BIGINT NOT NULL, 
    `nameValue` VARCHAR(40),

    FOREIGN KEY (`id_address`) REFERENCES `Address`(`id_address`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_scheduleOpen`) REFERENCES `ScheduleOpen`(`id_scheduleOpen`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `Position` (
    `id_position` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `positionValue` VARCHAR(50) NOT NULL
);

CREATE TABLE `Employee`(
    `id_employee` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_person` BIGINT NOT NULL,
    `id_office` BIGINT NOT NULL,
    `id_position` BIGINT NOT NOT,
    `startWorkingDate` DATE,

    FOREIGN KEY (`id_person`) REFERENCES `Person`(`id_person`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_office`) REFERENCES `Office`(`id_office`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_position`) REFERENCES `Position`(`id_position`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `CarHolder`(
    `id_carHolder` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_person` BIGINT NOT NULL,
    `carHolderNote` VARCHAR(100)
);

CREATE TABLE `CarBrand`(
    `id_carBrand` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `brandValue` VARCHAR(40) 
);

CREATE TABLE `CarModel`(
    `id_carModel` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `modelValue` VARCHAR(40)
);

CREATE TABLE `Color`(
    `id_color` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `colorValue` VARCHAR(40)
);

CREATE TABLE `Vehicle`(
    `id_vehicle` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_carHolder` BIGINT NOT NULL,
    `id_carBrand` BIGINT NOT NULL,
    `id_carModel` BIGINT NOT NULL,
    `id_color` BIGINT NOT NULL,
    `VIN_number` VARCHAR(30) UNIQUE NOT NULL,
    `registrationDate`  DATE NOT NULL, /*Поставлено на облік*/
    `deregistrationDate` DATE NULL, /*Знято із обліку*/

    FOREIGN KEY (`id_carHolder`) REFERENCES `CarHolder`(`id_carHolder`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_carBrand`) REFERENCES `CarBrand`(`id_carBrand`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_carModel`) REFERENCES `CarModel`(`id_carModel`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_color`) REFERENCES `Color`(`id_color`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `PlateSeriesCode`( /* KC */
    `id_plateSeriesCode` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `codeValue` CHAR(2) NOT NULL
);

CREATE TABLE `PlateRegionCode`( /* AB */
    `id_plateRegionCode` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_region` BIGINT NOT NULL,
    `codeValue` CHAR(2) NOT NULL,

    FOREIGN KEY (`id_region`) REFERENCES `Region`(`id_region`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `CarLicensePlate`( /* AB 7382 KC */
    `id_carLicensePlate` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_plateRegionCode` BIGINT, /* AB */ 
    `id_plateSeriesCode` BIGINT, /* KC */
    `isReservedPlateReserved` TINYINT,
    `plateValue` VARCHAR(15) NOT NULL, /* 7382 or 345-77KK */

    FOREIGN KEY (`id_plateRegionCode`) REFERENCES `PlateRegionCode`(`id_plateRegionCode`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_plateSeriesCode`) REFERENCES `PlateSeriesCode`(`id_plateSeriesCode`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `Record`(
    `id_record` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `id_carLicensePlate` BIGINT NOT NULL,
    `id_vehicle` BIGINT NOT NULL,
    `id_employee` BIGINT NOT NULL,
    `created_date` DATE NOT NULL, /*Дата запису до бази (не залежить від дати поставлення на облік, бувають випадки коли номера старого зназка і ще ніразу не були у базі)*/
    `note` VARCHAR(100),

    FOREIGN KEY (`id_carLicensePlate`) REFERENCES `CarLicensePlate`(`id_carLicensePlate`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_vehicle`) REFERENCES `Vehicle`(`id_vehicle`) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (`id_employee`) REFERENCES `Employee`(`id_employee`) ON DELETE RESTRICT ON UPDATE CASCADE
);