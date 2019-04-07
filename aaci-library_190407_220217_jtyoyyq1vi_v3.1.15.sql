-- MySQL dump 10.13  Distrib 8.0.15, for osx10.14 (x86_64)
--
-- Host: localhost    Database: aaci_2
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_heading` text,
  `field_shortDescription` text,
  `field_slogan` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cpnav_layout`
--

DROP TABLE IF EXISTS `cpnav_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cpnav_layout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `isDefault` tinyint(1) NOT NULL DEFAULT '0',
  `permissions` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cpnav_navigation`
--

DROP TABLE IF EXISTS `cpnav_navigation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cpnav_navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `prevLabel` varchar(255) DEFAULT NULL,
  `currLabel` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `order` int(11) DEFAULT '0',
  `prevUrl` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `customIcon` varchar(255) DEFAULT NULL,
  `manualNav` tinyint(1) NOT NULL DEFAULT '0',
  `newWindow` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cpnav_navigation_layoutId_fk` (`layoutId`),
  CONSTRAINT `cpnav_navigation_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `cpnav_layout` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrydrafts`
--

DROP TABLE IF EXISTS `entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entryversions`
--

DROP TABLE IF EXISTS `entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=340 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=389 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stc_resourcetagsfield`
--

DROP TABLE IF EXISTS `stc_resourcetagsfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stc_resourcetagsfield` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_resourcetagsfield_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_resourcetagsfield_siteId_idx` (`siteId`),
  CONSTRAINT `stc_resourcetagsfield_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_resourcetagsfield_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supertableblocks`
--

DROP TABLE IF EXISTS `supertableblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `supertableblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `supertableblocks_ownerId_idx` (`ownerId`),
  KEY `supertableblocks_fieldId_idx` (`fieldId`),
  KEY `supertableblocks_typeId_idx` (`typeId`),
  KEY `supertableblocks_sortOrder_idx` (`sortOrder`),
  KEY `supertableblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `supertableblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `supertableblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `supertableblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supertableblocktypes`
--

DROP TABLE IF EXISTS `supertableblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `supertableblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `supertableblocktypes_fieldId_idx` (`fieldId`),
  KEY `supertableblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `supertableblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'aaci_2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-07 18:02:17
-- MySQL dump 10.13  Distrib 8.0.15, for osx10.14 (x86_64)
--
-- Host: localhost    Database: aaci_2
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `assets` VALUES (7,7,10,'MassachusettsBillS2363AnActRelativeToOralCancerTherapy.pdf','pdf',NULL,NULL,102208,NULL,NULL,NULL,'2019-03-20 01:35:59','2019-03-14 00:43:34','2019-03-20 01:35:59','31d81acf-6c73-4a2a-9e5b-b715ba0ab0bb'),(8,7,10,'Bill1.pdf','pdf',NULL,NULL,249821,NULL,NULL,NULL,'2019-03-20 01:35:57','2019-03-14 00:43:38','2019-04-04 04:54:11','2b93c411-8df8-4fec-b336-b03907ac7c64'),(9,7,11,'States_Localities_Tobacco21.pdf','pdf',NULL,NULL,89868,NULL,NULL,NULL,'2019-03-20 01:37:29','2019-03-14 00:46:35','2019-03-20 01:37:29','bc374b8e-00a9-4667-ab9a-ed1942430f8c'),(10,4,6,'MassachusettsBillS2363AnActRelativeToOralCancerTherapy.pdf','pdf',NULL,NULL,102208,NULL,0,0,'2019-03-14 00:46:53','2019-03-14 00:46:53','2019-03-14 00:46:53','65f996de-d7b6-469d-bb17-b994b5a59f01'),(11,7,11,'IncreasingTheMinimumLegalSaleAgeForTobaccoProductsTo21Brief.pdf','pdf',NULL,NULL,472158,NULL,NULL,NULL,'2019-03-20 01:37:25','2019-03-14 00:47:10','2019-03-20 01:37:25','e7f2ec39-9af9-4664-82a7-682cc5ddb5dc'),(12,7,11,'IncreasingTheMinimumLegalSaleAgeForTobaccoProductsTo21.pdf','pdf',NULL,NULL,227474,NULL,NULL,NULL,'2019-03-20 01:37:23','2019-03-14 00:47:16','2019-03-20 01:37:23','5c1aebeb-8840-491a-a064-99fd466465e9'),(13,7,11,'H4479AnActProtectingYouthFromTheHealthRisksofTobaccoAndNicotineAddiction.pdf','pdf',NULL,NULL,128836,NULL,NULL,NULL,'2019-03-20 01:37:20','2019-03-14 00:47:23','2019-03-20 01:37:20','5c86c0e8-b318-4844-8a97-cb5847e1c3e1'),(14,7,12,'SAVING-WOMENS-LIVES-Accelerating-Action-to-Eliminate-Cervical-Cancer-Globally.pdf','pdf',NULL,NULL,4740757,NULL,NULL,NULL,'2019-03-20 01:40:35','2019-03-14 00:48:45','2019-03-20 01:40:35','7f1a4042-bf1d-42fb-8700-32c150afbc41'),(27,7,12,'Screen-Shot-2019-03-17-at-4.19.34-PM.png','image',2406,1712,273081,NULL,0,0,'2019-03-23 17:07:19','2019-03-23 17:07:19','2019-03-23 17:07:19','7ded1b75-711f-4095-94ce-703887dec91d'),(29,7,12,'Me-at-the-zoo.json','json',NULL,NULL,2594,NULL,NULL,NULL,'2019-03-25 16:48:52','2019-03-25 16:48:52','2019-03-25 16:48:52','4e1e18ab-5cd3-4686-8fb8-2d98a0121eff'),(35,7,13,'19-Survey-project-instructions-1.pdf','pdf',NULL,NULL,23908,NULL,NULL,NULL,'2019-03-26 12:09:11','2019-03-26 12:09:11','2019-03-26 12:09:11','281431fc-863d-471d-8d79-d6a58bd45c57'),(36,7,9,'Screen-Shot-2019-03-25-at-11.48.52-AM.png','image',2412,796,145139,NULL,0,0,'2019-03-27 01:57:42','2019-03-27 01:57:42','2019-03-27 01:57:42','374d720e-3859-4400-b052-54016456de3c'),(50,2,2,'img12.jpg','image',801,350,37462,NULL,NULL,NULL,'2019-04-02 19:20:16','2019-04-02 19:20:16','2019-04-02 19:20:16','e17b4d8b-4360-48f4-a4c7-6453e08887d0'),(51,1,1,'img01.jpg','image',1246,777,186603,NULL,NULL,NULL,'2019-04-02 19:28:10','2019-04-02 19:28:10','2019-04-02 19:28:10','3318ba30-4bb3-46a6-a289-bdfcea133a7d'),(52,1,1,'default.jpg','image',350,350,67960,NULL,NULL,NULL,'2019-04-02 20:51:54','2019-04-02 20:51:54','2019-04-02 20:51:59','5f4b7476-4c6c-4999-a5be-b331ca8ea600'),(56,2,2,'default.jpg','image',350,350,116195,NULL,NULL,NULL,'2019-04-07 20:21:18','2019-04-07 20:21:18','2019-04-07 20:23:28','7defc5fd-8ae5-4aef-8dcd-2f7138e59aa8');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categories` VALUES (20,2,NULL,0,'2019-03-20 01:14:43','2019-03-20 01:14:43','9dfbec02-8a11-49cf-a426-29d0ed294234'),(21,2,NULL,0,'2019-03-20 01:14:48','2019-03-20 01:14:53','0c19b6bd-096f-45c6-aab3-4e86f4a5e524');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups` VALUES (1,4,9,'Oral Chemotherapy Parity','oralChemotherapyParity','2019-03-20 01:09:35','2019-03-20 01:09:35','2019-03-20 01:10:58','10caf435-a080-480f-ac5e-093451b6ad11'),(2,5,NULL,'Topics test','topicsTest','2019-03-20 01:14:07','2019-03-20 01:14:30',NULL,'9daf7b14-27fe-44c5-a796-bd88508685be');
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups_sites` VALUES (1,1,1,1,'oral-chemotherapy-parity/{slug}','','2019-03-20 01:09:35','2019-03-20 01:09:35','9d088626-845d-42f4-9499-89ee96802398'),(2,2,1,1,'topics-test/{slug}','','2019-03-20 01:14:07','2019-03-20 01:14:30','8ed82153-8df7-4cfb-9e3d-87c1c1e73f29');
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2019-03-02 20:01:21','2019-03-30 19:18:15','53596661-1ef3-4bf5-b5b5-73fb17a38540',NULL,NULL,NULL),(2,2,1,'Home','2019-03-12 22:00:30','2019-04-04 04:41:10','57f3f2ba-60ac-4b15-ab0a-c8f18619a494','Cancer Resource Library',NULL,NULL),(3,3,1,'About','2019-03-12 22:00:42','2019-04-02 02:10:16','eba987b2-786a-4f69-855c-623be15482ff',NULL,NULL,NULL),(4,4,1,'Contact','2019-03-12 22:01:04','2019-04-02 02:10:18','60389922-1a45-4da6-8ec7-abc81acf56c9',NULL,NULL,NULL),(5,5,1,'Topics Index','2019-03-12 22:01:10','2019-03-19 12:54:25','fe58eeb8-e2e7-4e13-9ce6-cf71d874406b',NULL,NULL,NULL),(6,6,1,'Login','2019-03-12 22:01:17','2019-04-02 02:10:20','c884bba5-baa2-4618-812f-6799cb73eb34',NULL,NULL,NULL),(7,7,1,'Massachusetts Bill S2363An Act Relative To Oral Cancer Therapy','2019-03-14 00:43:34','2019-03-20 01:35:59','d766fc4a-36a0-406d-820d-eabb405a605a',NULL,NULL,NULL),(8,8,1,'The First Bill','2019-03-14 00:43:38','2019-04-04 04:54:11','38df6b95-ed6a-48b0-b1cf-ef5a34fae4ec',NULL,'This bill is about important stuff',NULL),(9,9,1,'States_Localities_Tobacco21','2019-03-14 00:46:35','2019-03-20 01:37:29','5db699bb-a544-487d-bc6b-27d0fee78465',NULL,NULL,NULL),(10,10,1,'Massachusetts Bill S2363An Act Relative To Oral Cancer Therapy','2019-03-14 00:46:53','2019-03-14 00:46:53','e88e318c-fa7b-452d-8c67-065fce780897',NULL,NULL,NULL),(11,11,1,'Increasing The Minimum Legal Sale Age For Tobacco Products To21Brief','2019-03-14 00:47:10','2019-03-20 01:37:25','87b3302c-b787-48a9-82a6-1fe7f9cb936b',NULL,NULL,NULL),(12,12,1,'Increasing The Minimum Legal Sale Age For Tobacco Products To21','2019-03-14 00:47:16','2019-03-20 01:37:23','57414e7d-1e18-4cd4-8b19-ef2915982fe0',NULL,NULL,NULL),(13,13,1,'H4479An Act Protecting Youth From The Health Risksof Tobacco And Nicotine Addiction','2019-03-14 00:47:23','2019-03-20 01:37:20','99e1a817-0a97-4342-bf87-92bf920261d7',NULL,NULL,NULL),(14,14,1,'SAVING-WOMENS-LIVES-Accelerating-Action-to-Eliminate-Cervical-Cancer-Globally','2019-03-14 00:48:45','2019-03-20 01:40:34','45873243-b77d-458b-a008-77adfa461b29',NULL,NULL,NULL),(15,15,1,'report','2019-03-16 19:31:37','2019-03-16 19:31:37','7768f9fa-7bfa-4e38-8e07-750789f8fbba',NULL,NULL,NULL),(16,16,1,'Testing Subtopic','2019-03-16 19:31:41','2019-03-16 19:31:46','1bec580d-0167-4920-998c-7ccbf83da81b',NULL,NULL,NULL),(17,17,1,'Testing Subtopic','2019-03-16 19:43:32','2019-03-16 19:43:32','7d873639-19ca-41d4-92d1-7ea4cf19920d',NULL,NULL,NULL),(18,18,1,'Subtopics Index','2019-03-16 20:08:46','2019-03-20 01:16:47','f22331f9-365f-4870-a2de-4ec0e75b476a',NULL,NULL,NULL),(19,19,1,'Oral Chemo','2019-03-16 20:11:25','2019-04-04 04:46:43','1f530883-3abc-4771-a814-fd39b822d160','Oral Chemotherapy Parity',NULL,NULL),(20,20,1,'Oral Chemotherapy Parity','2019-03-20 01:14:43','2019-03-20 01:14:43','5e7548eb-0fd9-45f5-a309-43f2e9bdc8bc',NULL,NULL,NULL),(21,21,1,'HPV Vaccination','2019-03-20 01:14:48','2019-03-20 01:14:53','a97f8bf8-07bf-44f2-b2ba-0619eae57824',NULL,NULL,NULL),(22,22,1,'HPV Vaccination','2019-03-20 01:30:31','2019-03-23 16:50:03','8f94557a-6713-4f06-bb50-6e3fbd55104a',NULL,NULL,NULL),(23,23,1,'Test Subtopic (for HPV Topic)','2019-03-20 14:54:28','2019-04-04 04:46:43','837ac5c3-e6c4-4a80-b636-844b715a5c78',NULL,NULL,NULL),(24,24,1,'Test Subtopic 2 (for HPV topic)','2019-03-20 14:54:49','2019-04-04 04:46:43','c2bc044c-04ca-42b9-b57b-abdd1d0b87eb',NULL,NULL,NULL),(25,25,1,'fdfff','2019-03-23 16:53:34','2019-03-23 16:53:34','b6ebb604-a092-4530-8b46-cd7676878acc',NULL,NULL,NULL),(26,26,1,'dffd','2019-03-23 16:53:38','2019-03-23 16:53:38','7c0fa3ce-445f-459b-a441-d9603a5a633f',NULL,NULL,NULL),(27,27,1,'Screen-Shot-2019-03-17-at-4.19.34-PM','2019-03-23 17:07:18','2019-03-23 17:07:18','ca01b5ec-140f-468b-bfce-3ec28713caa3',NULL,NULL,NULL),(28,28,1,'HPV','2019-03-23 17:33:14','2019-04-04 04:46:43','a4c5a5fb-90a5-44bb-8a32-d9facbfd1b60','HPV Vaccination','Human Papilloma Virus Vaccination Advocacy blah blah','pls get vaccinated'),(29,29,1,'Me at the zoo','2019-03-25 16:48:52','2019-03-25 16:48:52','6c12b493-99a8-40d0-9118-15c1b1582131',NULL,NULL,NULL),(30,31,1,'hello','2019-03-26 00:38:51','2019-03-26 00:38:51','13eb033c-47fc-43b5-87ce-7e2e78778919',NULL,NULL,NULL),(31,32,1,'content test','2019-03-26 00:39:41','2019-03-27 19:25:51','9c0ab09d-2b93-4519-8ced-f2b3c0c376d7',NULL,NULL,NULL),(32,33,1,'a','2019-03-26 00:45:53','2019-03-26 00:45:53','49ed5f53-327b-4cae-816d-aafb5914f455',NULL,NULL,NULL),(33,34,1,'b]','2019-03-26 00:45:56','2019-03-26 00:45:56','9f255172-e5b3-4ddb-a6d4-6575da82329c',NULL,NULL,NULL),(34,35,1,'19-Survey-project-instructions-1','2019-03-26 12:09:11','2019-03-26 12:09:11','4153da9c-b92c-4967-bd32-91fac347d602',NULL,NULL,NULL),(35,36,1,'Screen-Shot-2019-03-25-at-11.48.52-AM','2019-03-27 01:57:41','2019-03-27 01:57:41','d2889d2f-20b0-4289-8336-7b2574b16802',NULL,NULL,NULL),(36,37,1,'fdf','2019-03-28 16:13:35','2019-03-28 16:13:35','a92148f0-d971-495f-ae1e-9a469aa4c30e',NULL,NULL,NULL),(37,38,1,'c','2019-03-28 16:19:01','2019-03-28 16:19:01','392f8bd4-5cdb-424e-9bc0-d4b4dcc88ec6',NULL,NULL,NULL),(38,39,1,'b','2019-03-28 16:19:03','2019-03-28 16:19:03','06d69dda-67ae-48bf-a933-f9916a2c9d3f',NULL,NULL,NULL),(39,40,1,'d','2019-03-28 16:19:06','2019-03-28 16:19:06','b2fd7e25-12e4-4655-8d68-66c0fd2acf11',NULL,NULL,NULL),(40,42,1,'oral subtopic','2019-03-28 16:19:38','2019-04-04 04:46:43','1d70a5f4-4342-486c-9a93-e36248b71a15','oral subtopic heading',NULL,NULL),(41,43,1,NULL,'2019-03-29 20:12:17','2019-03-29 20:26:09','83b271f8-6b41-48f7-bf05-42d586849b03',NULL,NULL,NULL),(42,44,1,NULL,'2019-03-29 20:13:47','2019-03-29 20:13:47','8285ce8f-4816-40be-b125-bca808c3010e',NULL,NULL,NULL),(43,45,1,NULL,'2019-03-30 19:46:57','2019-03-30 19:49:31','c97a532c-fda5-4afe-89ea-266fd21dc955',NULL,NULL,NULL),(44,46,1,'Pennsylvania','2019-04-01 02:18:27','2019-04-01 02:18:27','847ced6a-74af-4e43-8273-eaf89c42d8d8',NULL,NULL,NULL),(45,47,1,'About','2019-04-02 02:11:50','2019-04-04 04:40:58','2a836d1b-c121-43d4-99da-c133f8dc0ef5','About Us',NULL,NULL),(46,48,1,'Topics Index','2019-04-02 02:23:21','2019-04-04 04:38:00','e10215cc-6ea3-41c8-a2d7-47ef7e7e4fd0','Topics',NULL,NULL),(47,49,1,'Tobacco 21','2019-04-02 18:45:55','2019-04-04 04:46:43','b27d574b-a65c-4bfd-89da-4d5b14a9ce80','Tobacco 21',NULL,NULL),(48,50,1,'Img12','2019-04-02 19:20:16','2019-04-02 19:20:16','1fe41af2-4c98-41b2-a115-c17b26815b16',NULL,NULL,NULL),(49,51,1,'Img01','2019-04-02 19:28:10','2019-04-02 19:28:10','ae7b68db-9b17-4633-b9c0-1525c5089dd8',NULL,NULL,NULL),(50,52,1,'Default','2019-04-02 20:51:53','2019-04-02 20:51:58','fdec8270-cec6-4c53-ac8d-cdd52af2bc9d',NULL,NULL,NULL),(51,53,1,'California','2019-04-04 04:53:56','2019-04-04 04:53:56','32193ba9-982f-4aa4-b58b-d4656bff000a',NULL,NULL,NULL),(52,54,1,'pdf','2019-04-04 04:54:04','2019-04-04 04:54:04','67c26e8a-5fac-43b3-8d6b-6446417403b1',NULL,NULL,NULL),(53,55,1,'AACI','2019-04-04 04:54:10','2019-04-04 04:54:10','0420d230-97b8-4fc8-90aa-9544196ce43c',NULL,NULL,NULL),(54,56,1,'Default','2019-04-07 20:21:18','2019-04-07 20:23:28','5d183108-0594-4f10-a839-5bad2997a871',NULL,NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `cpnav_layout`
--

LOCK TABLES `cpnav_layout` WRITE;
/*!40000 ALTER TABLE `cpnav_layout` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `cpnav_layout` VALUES (1,'Default',1,NULL,'2019-03-25 16:14:40','2019-03-25 16:14:40','6683c9ac-5d1f-4714-8294-69fad709380d');
/*!40000 ALTER TABLE `cpnav_layout` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `cpnav_navigation`
--

LOCK TABLES `cpnav_navigation` WRITE;
/*!40000 ALTER TABLE `cpnav_navigation` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `cpnav_navigation` VALUES (1,1,'dashboard','Dashboard','Dashboard',1,0,'dashboard','dashboard','gauge',NULL,0,0,'2019-03-25 16:14:40','2019-03-28 16:10:08','77e9f445-3f57-4461-8bee-c7e308b26747'),(2,1,'entries','Entries','Pages',1,1,'entries','entries','section',NULL,0,0,'2019-03-25 16:14:40','2019-04-02 17:17:03','984fa418-d1c9-4e1f-84ae-20695c14413c'),(3,1,'categories','Categories','Categories',0,2,'categories','categories','categories',NULL,0,0,'2019-03-25 16:14:40','2019-03-25 16:15:16','b55f9c3c-4f38-40e9-a87e-a995df104c50'),(4,1,'tags','Tags','Tags',1,3,'tags','tags','/Users/erikagiuse/Documents/67373/craft3/vendor/ether/tags/src/icon-mask.svg',NULL,0,0,'2019-03-25 16:14:40','2019-03-25 16:14:40','9e7591ac-c008-4ca8-a520-ad279cc0dc14'),(5,1,'assets','Assets','Assets',1,4,'assets','assets','assets',NULL,0,0,'2019-03-25 16:14:40','2019-04-02 20:51:32','5942014d-448f-477e-a8c0-7ffeac902cee'),(6,1,'utilities','Utilities','Utilities',1,5,'utilities','utilities','tool',NULL,0,0,'2019-03-25 16:14:40','2019-04-07 18:39:46','24250fef-e418-425d-8de5-1c7b9d738d62'),(7,1,'settings','Settings','Settings',1,6,'settings','settings','settings',NULL,0,0,'2019-03-25 16:14:40','2019-04-02 20:45:10','732930f9-c565-4870-a436-d3928992dcf5'),(8,1,'plugin-store','Plugin Store','Plugin Store',0,7,'plugin-store','plugin-store','plugin',NULL,0,0,'2019-03-25 16:14:40','2019-04-01 02:03:35','0f0e24fe-01ef-40cf-9e8c-9dbafcdbfc3f'),(10,1,'users','Users','Users',0,5,'users','users','users',NULL,0,0,'2019-03-29 19:57:13','2019-04-01 02:03:34','65ca9a56-5864-478f-b771-4e8bffb7c4dc');
/*!40000 ALTER TABLE `cpnav_navigation` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elementindexsettings` VALUES (1,'craft\\elements\\Entry','{\"sources\":{\"section:c469a882-e929-4b33-9e7b-bea1c720755e\":{\"tableAttributes\":{\"1\":\"uri\",\"2\":\"_childme_addChild\"}},\"single:6bf6ecfb-cd83-47f9-8c99-d75b4e1b9b89\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"author\",\"3\":\"uri\"}},\"*\":{\"tableAttributes\":{\"1\":\"section\",\"2\":\"postDate\",\"3\":\"author\",\"4\":\"link\",\"5\":\"_childme_addChild\"}},\"single:467a7187-2226-4c46-bcc4-3b390493f66a\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"author\",\"3\":\"uri\"}},\"single:3323900d-bc90-4c77-8638-89fe3d9baaa1\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"author\",\"3\":\"uri\"}}},\"sourceOrder\":[[\"key\",\"*\"],[\"heading\",\"Nav Bar Pages\"],[\"key\",\"single:6bf6ecfb-cd83-47f9-8c99-d75b4e1b9b89\"],[\"key\",\"single:3323900d-bc90-4c77-8638-89fe3d9baaa1\"],[\"key\",\"single:467a7187-2226-4c46-bcc4-3b390493f66a\"],[\"heading\",\"Topics\"],[\"key\",\"section:c469a882-e929-4b33-9e7b-bea1c720755e\"]]}','2019-04-02 17:27:51','2019-04-02 17:27:51','0a9e8ad9-3b0f-4bce-b15d-fe3796f37859'),(2,'craft\\elements\\Asset','{\"sources\":{\"folder:c6a8fd96-0149-49ab-80d2-496663e80dec\":{\"tableAttributes\":{\"1\":\"filename\",\"2\":\"dateModified\",\"3\":\"link\"}},\"folder:fc77a882-4cd8-46d3-a071-0cf98b829216\":{\"tableAttributes\":{\"1\":\"filename\",\"2\":\"size\",\"3\":\"dateModified\",\"4\":\"link\"}}},\"sourceOrder\":[[\"key\",\"folder:c6a8fd96-0149-49ab-80d2-496663e80dec\"],[\"key\",\"folder:11768569-5676-4b28-bb57-58ada962f702\"],[\"key\",\"folder:ad88d87e-3879-4f17-b8c2-9ac432414fc5\"],[\"key\",\"folder:fc77a882-4cd8-46d3-a071-0cf98b829216\"]]}','2019-04-02 20:16:37','2019-04-02 20:16:37','c3e12372-e397-470c-a38d-09a380f783b2'),(8,'ether\\tagManager\\elements\\Tag','{\"sourceOrder\":[[\"key\",\"*\"],[\"heading\",\"Tag Groups\"],[\"key\",\"taggroup:10\"],[\"key\",\"taggroup:11\"],[\"heading\",\"Types of Tags\"],[\"key\",\"taggroup:9\"],[\"key\",\"taggroup:1\"],[\"key\",\"taggroup:6\"],[\"key\",\"taggroup:8\"],[\"key\",\"taggroup:7\"],[\"key\",\"taggroup:5\"],[\"key\",\"taggroup:4\"]],\"sources\":{\"taggroup:11\":{\"tableAttributes\":{\"1\":\"group\",\"2\":\"dateCreated\",\"3\":\"dateUpdated\"}},\"taggroup:9\":{\"tableAttributes\":{\"1\":\"group\",\"2\":\"dateCreated\",\"3\":\"dateUpdated\"}},\"taggroup:1\":{\"tableAttributes\":{\"1\":\"group\",\"2\":\"dateCreated\",\"3\":\"dateUpdated\"}}}}','2019-03-26 00:37:07','2019-03-26 00:37:07','9de540ab-d88d-425a-bb04-178fff66ab59');
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2019-03-02 20:01:21','2019-03-30 19:18:15',NULL,'204682cf-1005-4b14-ae5f-7c3a0e7719e6'),(2,16,'craft\\elements\\Entry',1,0,'2019-03-12 22:00:30','2019-04-04 04:41:10',NULL,'010c4203-eed1-4118-9909-9ef3b03ecaca'),(3,NULL,'craft\\elements\\Entry',1,0,'2019-03-12 22:00:42','2019-04-02 02:10:16','2019-04-02 02:10:16','5114d5ec-10fd-4333-9d0a-8cbcd217d144'),(4,NULL,'craft\\elements\\Entry',1,0,'2019-03-12 22:01:04','2019-04-02 02:10:18','2019-04-02 02:10:18','66334099-263f-417e-889c-b6564c5ca22b'),(5,NULL,'craft\\elements\\Entry',1,0,'2019-03-12 22:01:10','2019-03-19 12:54:25','2019-03-20 01:31:24','0b03dd1b-a75b-4db9-bc56-ad7c7fbe1694'),(6,NULL,'craft\\elements\\Entry',1,0,'2019-03-12 22:01:17','2019-04-02 02:10:20','2019-04-02 02:10:20','c1282d76-0a84-447f-9eb9-0123f659118b'),(7,NULL,'craft\\elements\\Asset',1,0,'2019-03-14 00:43:34','2019-03-20 01:35:59',NULL,'3fb16428-e9be-4416-88b7-0bea7cb48348'),(8,15,'craft\\elements\\Asset',1,0,'2019-03-14 00:43:38','2019-04-04 04:54:11',NULL,'be63b18a-66b9-4794-a135-74a644320835'),(9,NULL,'craft\\elements\\Asset',1,0,'2019-03-14 00:46:35','2019-03-20 01:37:29',NULL,'e1f4cbdf-8d40-4e8d-b976-185ea0a925a1'),(10,NULL,'craft\\elements\\Asset',1,0,'2019-03-14 00:46:53','2019-03-14 00:46:53','2019-03-14 00:46:59','9bccc9f0-1183-49f5-a78d-e4811716391c'),(11,NULL,'craft\\elements\\Asset',1,0,'2019-03-14 00:47:10','2019-03-20 01:37:25',NULL,'27f1dfb5-13e1-4330-b391-69f8b6678b7d'),(12,NULL,'craft\\elements\\Asset',1,0,'2019-03-14 00:47:16','2019-03-20 01:37:23',NULL,'d817a97e-0f61-4df1-8f98-b06fc762d4ce'),(13,NULL,'craft\\elements\\Asset',1,0,'2019-03-14 00:47:23','2019-03-20 01:37:20',NULL,'836c5a73-4b54-4581-bb6d-983bd1fd1195'),(14,NULL,'craft\\elements\\Asset',1,0,'2019-03-14 00:48:45','2019-03-20 01:40:34',NULL,'1b11a675-a8f3-4979-b71d-5650f9415a50'),(15,7,'craft\\elements\\Tag',1,0,'2019-03-16 19:31:37','2019-03-16 19:31:37','2019-03-25 15:55:16','afd534a8-78f4-4bd5-b329-4847b26dfbcb'),(16,8,'craft\\elements\\Entry',1,0,'2019-03-16 19:31:41','2019-03-16 19:31:46','2019-03-16 19:31:52','c66df418-6b20-4347-bede-9ef5d16f559e'),(17,8,'craft\\elements\\Entry',1,0,'2019-03-16 19:43:32','2019-03-16 19:43:32','2019-03-16 19:43:47','fa784ee3-7ef6-4284-b695-c1c5e35d99a5'),(18,NULL,'craft\\elements\\Entry',1,0,'2019-03-16 20:08:46','2019-03-20 01:16:47','2019-03-20 01:16:47','f42f3a4b-f40c-4745-aa68-642a5a55991d'),(19,8,'craft\\elements\\Entry',1,0,'2019-03-16 20:11:25','2019-04-04 04:46:43',NULL,'46080a11-3869-46e5-b096-c4cbcf3d6b22'),(20,NULL,'craft\\elements\\Category',1,0,'2019-03-20 01:14:43','2019-03-20 01:14:43','2019-03-20 01:15:55','90d01244-f7e0-4490-8552-2ec9c8497416'),(21,NULL,'craft\\elements\\Category',1,0,'2019-03-20 01:14:48','2019-03-20 01:14:53','2019-03-20 01:15:55','f39c1356-a022-4dd1-b422-a279282fdb08'),(22,8,'craft\\elements\\Entry',1,0,'2019-03-20 01:30:31','2019-03-23 16:50:03','2019-03-23 16:56:18','206df1b8-0851-40d1-91ea-bcb7294e59dd'),(23,8,'craft\\elements\\Entry',0,0,'2019-03-20 14:54:28','2019-04-04 04:46:43',NULL,'a32abfa6-7ded-45f5-adf2-8e3d33369f33'),(24,8,'craft\\elements\\Entry',0,0,'2019-03-20 14:54:49','2019-04-04 04:46:43',NULL,'69787064-1998-46fb-91c8-ef376905d9e1'),(25,7,'craft\\elements\\Tag',1,0,'2019-03-23 16:53:34','2019-03-23 16:53:34','2019-03-25 15:55:16','2853308e-8c9d-4835-95e3-22616041bc6b'),(26,7,'craft\\elements\\Tag',1,0,'2019-03-23 16:53:38','2019-03-23 16:53:38','2019-03-25 15:55:16','9082d73e-ceac-4b86-a469-a7f4b007b664'),(27,10,'craft\\elements\\Asset',1,0,'2019-03-23 17:07:18','2019-03-23 17:07:18','2019-03-23 17:07:25','7f4ccb24-d94c-47bd-923b-c192154ee3f2'),(28,8,'craft\\elements\\Entry',1,0,'2019-03-23 17:33:14','2019-04-04 04:46:43',NULL,'cf0a3b9a-2ea2-4889-93e9-41d2cecaacab'),(29,10,'craft\\elements\\Asset',1,0,'2019-03-25 16:48:52','2019-03-25 16:48:52',NULL,'514c1109-8033-4096-81ea-37a272381c7f'),(30,11,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2019-03-26 00:31:32','2019-03-26 00:51:49','2019-03-26 00:55:19','99ae0835-eca4-444c-be69-6b2f67a66288'),(31,NULL,'craft\\elements\\Tag',1,0,'2019-03-26 00:38:51','2019-03-26 00:38:51','2019-04-01 02:18:20','87984c51-7eb6-49dc-86db-c222bdc0c962'),(32,7,'craft\\elements\\Tag',1,0,'2019-03-26 00:39:41','2019-03-27 19:25:51','2019-04-01 02:18:45','55db46d6-991a-4d7b-a995-9579b1f869b3'),(33,NULL,'craft\\elements\\Tag',1,0,'2019-03-26 00:45:53','2019-03-26 00:45:53','2019-04-01 02:18:20','fd416abb-20da-4b20-bf95-b6544ad227ce'),(34,NULL,'craft\\elements\\Tag',1,0,'2019-03-26 00:45:56','2019-03-26 00:45:56','2019-04-01 02:18:20','e5c3ffde-e0d9-4485-80f0-53be1421dfd8'),(35,10,'craft\\elements\\Asset',1,0,'2019-03-26 12:09:11','2019-03-26 12:09:11',NULL,'951bb0a3-0783-40c6-8775-f37f2a5912db'),(36,15,'craft\\elements\\Asset',1,0,'2019-03-27 01:57:41','2019-03-27 01:57:41','2019-03-30 19:06:22','44aa5298-e1fa-49ad-9476-81d8ea4b3662'),(37,8,'craft\\elements\\Entry',1,0,'2019-03-28 16:13:35','2019-03-28 16:13:35','2019-03-28 16:13:54','9f35a09c-770c-4dc7-b35e-792fdd65b1e0'),(38,1,'craft\\elements\\Tag',1,0,'2019-03-28 16:19:01','2019-03-28 16:19:01',NULL,'10cb707a-a15a-446f-b599-930191cd46d2'),(39,7,'craft\\elements\\Tag',1,0,'2019-03-28 16:19:03','2019-03-28 16:19:03','2019-04-01 02:18:45','8db7f044-39d1-4187-826e-54543e60a6fd'),(40,NULL,'craft\\elements\\Tag',1,0,'2019-03-28 16:19:06','2019-03-28 16:19:06','2019-04-01 02:18:12','8b76904f-91e8-4cb1-a284-597222637a4d'),(41,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2019-03-28 16:19:07','2019-04-04 04:54:11',NULL,'9b0fdb67-7655-408c-a50d-e96ad959f22f'),(42,8,'craft\\elements\\Entry',1,0,'2019-03-28 16:19:38','2019-04-04 04:46:43',NULL,'b49a8a84-2868-4cfe-8c45-34beeb020b53'),(43,NULL,'craft\\elements\\User',1,0,'2019-03-29 20:12:17','2019-03-29 20:26:08','2019-03-30 17:46:36','3a91d465-aa35-46ef-96dd-bcdc07e665c0'),(44,NULL,'craft\\elements\\User',1,0,'2019-03-29 20:13:47','2019-03-29 20:13:47','2019-03-30 19:42:59','706e3bd4-4959-439c-9f6f-2ad0104d2bb2'),(45,NULL,'craft\\elements\\User',1,0,'2019-03-30 19:46:57','2019-03-30 19:49:31',NULL,'c837c108-946b-40c4-859d-528d54ea6c84'),(46,NULL,'craft\\elements\\Tag',1,0,'2019-04-01 02:18:27','2019-04-01 02:18:27',NULL,'6c95c1d1-c418-439d-acdc-3246c169e23e'),(47,18,'craft\\elements\\Entry',1,0,'2019-04-02 02:11:50','2019-04-04 04:40:58',NULL,'1648e162-19f3-4e2e-aa1b-947fc5e45ee4'),(48,17,'craft\\elements\\Entry',1,0,'2019-04-02 02:23:21','2019-04-04 04:38:00',NULL,'e8664729-6f93-4619-8e46-a96d66975596'),(49,8,'craft\\elements\\Entry',1,0,'2019-04-02 18:45:55','2019-04-04 04:46:43',NULL,'9baa1d20-d369-4886-971e-59750ec3be90'),(50,NULL,'craft\\elements\\Asset',1,0,'2019-04-02 19:20:16','2019-04-02 19:20:16',NULL,'6cc0d729-e672-43b6-94f4-10d461e2f353'),(51,NULL,'craft\\elements\\Asset',1,0,'2019-04-02 19:28:10','2019-04-02 19:28:10',NULL,'c5fae4cd-57b0-41fa-b07e-b891d8fec9ef'),(52,NULL,'craft\\elements\\Asset',1,0,'2019-04-02 20:51:53','2019-04-02 20:51:58',NULL,'6c799842-0c30-4286-b87b-9dc4ecefd969'),(53,NULL,'craft\\elements\\Tag',1,0,'2019-04-04 04:53:56','2019-04-04 04:53:56',NULL,'6344e01a-8e16-402f-83f0-e33fa3fb3b9d'),(54,1,'craft\\elements\\Tag',1,0,'2019-04-04 04:54:04','2019-04-04 04:54:04',NULL,'874791a9-df38-456f-a47b-1414a0bfd359'),(55,NULL,'craft\\elements\\Tag',1,0,'2019-04-04 04:54:10','2019-04-04 04:54:10',NULL,'41ea410c-d60b-42b2-b414-b88ef00a6339'),(56,NULL,'craft\\elements\\Asset',1,0,'2019-04-07 20:21:18','2019-04-07 20:23:28',NULL,'56fdf31e-8c85-4cdc-a46f-708fb2eab317');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-03-02 20:01:21','2019-03-30 19:18:15','5701f88c-5cd7-4a28-8f21-a5e5c100821f'),(2,2,1,'home','__home__',1,'2019-03-12 22:00:30','2019-04-04 04:41:10','8537ad87-ecb8-4e54-b876-4512a3b4ca72'),(3,3,1,'about','about',1,'2019-03-12 22:00:42','2019-04-02 02:10:16','3ccb734a-4b5b-4f36-83b0-838462ba73ef'),(4,4,1,'contact','contact',1,'2019-03-12 22:01:04','2019-04-02 02:10:18','60e0d6bb-4e2c-48e2-af5e-933a976c1d53'),(5,5,1,'topics','topics',1,'2019-03-12 22:01:10','2019-03-19 12:54:25','8c9061cd-de21-4109-9292-8de912dc3b68'),(6,6,1,'login','login',1,'2019-03-12 22:01:17','2019-04-02 02:10:20','ac257e46-4205-4970-a947-c8d31d185930'),(7,7,1,NULL,NULL,1,'2019-03-14 00:43:34','2019-03-20 01:35:59','bb2aa31f-b75b-4ed1-984d-a02474c0fa3b'),(8,8,1,NULL,NULL,1,'2019-03-14 00:43:38','2019-04-04 04:54:11','9b79648f-b830-4aa6-a70d-fee991596273'),(9,9,1,NULL,NULL,1,'2019-03-14 00:46:35','2019-03-20 01:37:29','5f2263d5-cc82-404b-96c4-eb7469de1f33'),(10,10,1,NULL,NULL,1,'2019-03-14 00:46:53','2019-03-14 00:46:53','a3208daf-bab9-4c7f-b971-9b2d8df0ede1'),(11,11,1,NULL,NULL,1,'2019-03-14 00:47:10','2019-03-20 01:37:25','34f3642a-d926-4e38-b0fa-7ff81550085e'),(12,12,1,NULL,NULL,1,'2019-03-14 00:47:16','2019-03-20 01:37:23','7f584c5e-b0da-4506-bb31-d1fcca8ff938'),(13,13,1,NULL,NULL,1,'2019-03-14 00:47:23','2019-03-20 01:37:20','215aa04f-b3b4-41d9-8b80-6e7ad80dd93a'),(14,14,1,NULL,NULL,1,'2019-03-14 00:48:45','2019-03-20 01:40:34','e49f7e6f-d220-44e7-aacc-b572968e9af2'),(15,15,1,'report',NULL,1,'2019-03-16 19:31:37','2019-03-16 19:31:37','e011451f-1a71-4fb0-9679-bf00b943a00b'),(16,16,1,'testing-subtopic','subtopics/testing-subtopic',1,'2019-03-16 19:31:41','2019-03-16 19:31:46','43c4faf9-3c06-4944-823c-050aa7313bc0'),(17,17,1,'testing-subtopic','subtopics/testing-subtopic',1,'2019-03-16 19:43:32','2019-03-16 19:43:32','22f10e55-7096-44f0-a66d-2443934b9d54'),(18,18,1,'subtopics-index','subtopics',1,'2019-03-16 20:08:46','2019-03-20 01:16:47','223136a1-3906-4d21-96dd-3bfe4d60d1ce'),(19,19,1,'oral-chemotherapy-parity','oral-chemotherapy-parity',1,'2019-03-16 20:11:25','2019-04-04 04:46:43','f94716f4-e5dd-45a7-bd8f-b0bb647af0d4'),(20,20,1,'oral-chemotherapy-parity','topics-test/oral-chemotherapy-parity',1,'2019-03-20 01:14:43','2019-03-20 01:14:44','cb618cb6-d701-4544-bca5-fc987804cb8f'),(21,21,1,'hpv-vaccinatino','topics-test/hpv-vaccinatino',1,'2019-03-20 01:14:48','2019-03-20 01:14:53','e8f44ecb-3ceb-4a7b-8836-c659ee08b237'),(22,22,1,'hpv-vaccination','subtopics/hpv-vaccination',1,'2019-03-20 01:30:31','2019-03-23 16:50:03','e2a5b779-da61-4332-ae4d-e257ac412d4a'),(23,23,1,'test-subtopic-for-hpv-topic','hpv/test-subtopic-for-hpv-topic',1,'2019-03-20 14:54:28','2019-04-04 04:46:43','f90a2f7f-122c-4b66-9fdb-379c01dbadfa'),(24,24,1,'test-subtopic-2-for-hpv-topic','hpv/test-subtopic-2-for-hpv-topic',1,'2019-03-20 14:54:49','2019-04-04 04:46:43','cc6712c3-ac5c-4e36-baf3-d991a1589138'),(25,25,1,'fdfff',NULL,1,'2019-03-23 16:53:34','2019-03-23 16:53:34','bd3c01e5-641a-479c-b751-be69db39be51'),(26,26,1,'dffd',NULL,1,'2019-03-23 16:53:38','2019-03-23 16:53:38','aba8a37d-2ff8-44b5-9e4c-870119fe5b41'),(27,27,1,NULL,NULL,1,'2019-03-23 17:07:18','2019-03-23 17:07:18','133ea689-7712-4a95-b0a9-f2dffeb1e6e2'),(28,28,1,'hpv','hpv',1,'2019-03-23 17:33:14','2019-04-04 04:46:43','560c8a96-aece-41d1-8be5-60a27d5f61a5'),(29,29,1,NULL,NULL,1,'2019-03-25 16:48:52','2019-03-25 16:48:52','a78577fe-c5c8-4fcb-a26c-db6259e05794'),(30,30,1,NULL,NULL,1,'2019-03-26 00:31:32','2019-03-26 00:51:49','bda6b941-cdb4-4ed3-8d1a-04c028ea68db'),(31,31,1,'hello',NULL,1,'2019-03-26 00:38:51','2019-03-26 00:38:51','57965111-0686-47db-bb5b-4b77dbef1c63'),(32,32,1,'content-test',NULL,1,'2019-03-26 00:39:41','2019-03-27 19:25:51','57b4db48-0ba4-4cb4-9254-f61bd21bbb99'),(33,33,1,'a',NULL,1,'2019-03-26 00:45:53','2019-03-26 00:45:53','3cee92bb-7b0b-4395-8373-d2f10cea8beb'),(34,34,1,'b',NULL,1,'2019-03-26 00:45:56','2019-03-26 00:45:56','df6e4ac6-52e1-4439-991a-f19d5bef3258'),(35,35,1,NULL,NULL,1,'2019-03-26 12:09:11','2019-03-26 12:09:11','974b9880-7b27-45b4-a291-1bfe19fc4e24'),(36,36,1,NULL,NULL,1,'2019-03-27 01:57:41','2019-03-27 01:57:41','cd8a674e-bfa6-4fb3-8677-a3956111b825'),(37,37,1,'fdf','subtopics/fdf',1,'2019-03-28 16:13:35','2019-03-28 16:13:47','4685ece1-95cd-41f0-8a0f-de5ea1b77060'),(38,38,1,'c',NULL,1,'2019-03-28 16:19:01','2019-03-28 16:19:01','9e244da1-160b-4d32-8b72-ce0f9d1a41fb'),(39,39,1,'b',NULL,1,'2019-03-28 16:19:03','2019-03-28 16:19:03','3a3ad0ed-d6de-403c-8f66-f650f6746a9d'),(40,40,1,'d',NULL,1,'2019-03-28 16:19:06','2019-03-28 16:19:06','40d6b690-cb5f-450c-ad74-7a92b7a94c71'),(41,41,1,NULL,NULL,1,'2019-03-28 16:19:07','2019-04-04 04:54:11','a017c1f6-dae0-4a5c-80a8-0e1c63cca434'),(42,42,1,'oral-subtopic','oral-chemotherapy-parity/oral-subtopic',1,'2019-03-28 16:19:38','2019-04-04 04:46:43','58ecb2f3-591b-4cba-a511-9ebf5db7ac98'),(43,43,1,NULL,NULL,1,'2019-03-29 20:12:17','2019-03-29 20:26:09','f7a61284-02a3-4a97-98f8-6f4f45bc13ed'),(44,44,1,NULL,NULL,1,'2019-03-29 20:13:47','2019-03-29 20:13:47','0914cad1-a06f-49c2-b7c3-0b37ea72c40f'),(45,45,1,NULL,NULL,1,'2019-03-30 19:46:57','2019-03-30 19:49:31','6c451da9-d494-4e41-a322-61011610d110'),(46,46,1,'pennsylvania',NULL,1,'2019-04-01 02:18:27','2019-04-01 02:18:27','e80faf53-8282-41d6-bb1e-1b2a0b41d022'),(47,47,1,'about','about',1,'2019-04-02 02:11:50','2019-04-04 04:40:58','877ab088-730b-40c5-9ea8-53476d608412'),(48,48,1,'topics-index','topics',1,'2019-04-02 02:23:21','2019-04-04 04:38:00','24ea0ee5-0da3-4f96-b610-f9d9313433b1'),(49,49,1,'tobacco-21','tobacco-21',1,'2019-04-02 18:45:55','2019-04-04 04:46:43','16d30a00-1354-44c1-9992-3b849585dd75'),(50,50,1,NULL,NULL,1,'2019-04-02 19:20:16','2019-04-02 19:20:16','fa9bfb94-f34a-4dbe-b741-2e8da21b6108'),(51,51,1,NULL,NULL,1,'2019-04-02 19:28:10','2019-04-02 19:28:10','cc055804-d066-46a0-bbb8-2f4a71bc1c0c'),(52,52,1,NULL,NULL,1,'2019-04-02 20:51:53','2019-04-02 20:51:58','2c47376f-dd16-4f87-a0ec-67db287dcf2d'),(53,53,1,'california',NULL,1,'2019-04-04 04:53:56','2019-04-04 04:53:56','62a48285-823c-4d01-b73c-a61baee40d1b'),(54,54,1,'pdf',NULL,1,'2019-04-04 04:54:04','2019-04-04 04:54:04','7e0bc538-302d-4e00-b89d-128a480dd17f'),(55,55,1,'aaci',NULL,1,'2019-04-04 04:54:10','2019-04-04 04:54:10','c957f2b1-5283-4acc-9dba-874358fd0c49'),(56,56,1,NULL,NULL,1,'2019-04-07 20:21:18','2019-04-07 20:23:28','bbdd23d0-d972-4657-93ef-5fe900dc34ff');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,1,NULL,1,NULL,'2019-03-12 22:00:00',NULL,NULL,'2019-03-12 22:00:30','2019-04-04 04:41:10','9169d641-3157-4f8c-af19-304ba0a4a2e4'),(3,2,NULL,2,NULL,'2019-03-12 22:00:00',NULL,1,'2019-03-12 22:00:42','2019-04-02 02:10:16','fe2833be-c508-4275-8c9e-714dd9de9fbe'),(4,3,NULL,3,NULL,'2019-03-12 22:01:00',NULL,1,'2019-03-12 22:01:04','2019-04-02 02:10:18','2f69a7d3-50bf-4d3c-92be-7a833f408403'),(5,4,NULL,4,1,'2019-03-12 22:01:00',NULL,1,'2019-03-12 22:01:10','2019-03-19 12:54:26','8299bcc1-04f1-4086-b2ac-a2be7544c442'),(6,5,NULL,5,NULL,'2019-03-12 22:01:00',NULL,1,'2019-03-12 22:01:17','2019-04-02 02:10:20','359e3e27-543f-4ee7-8005-ea808a51dc68'),(16,7,NULL,7,1,'2019-03-16 19:31:00',NULL,0,'2019-03-16 19:31:41','2019-03-16 19:31:46','e80152b2-bb29-408a-8a99-66d5547aad4a'),(17,7,NULL,7,1,'2019-03-16 19:43:00',NULL,0,'2019-03-16 19:43:32','2019-03-16 19:43:32','c1e12eae-a2d1-427e-9cb3-2b2dfda6347e'),(18,8,NULL,8,NULL,'2019-03-16 20:08:00',NULL,1,'2019-03-16 20:08:46','2019-03-20 01:16:47','83f1105d-6615-45bd-a7d2-ff5c7c1dff61'),(19,7,NULL,7,1,'2019-03-16 20:11:00',NULL,NULL,'2019-03-16 20:11:25','2019-04-04 04:46:43','4859c572-57cf-4b28-9e9f-1c1b2403c8d1'),(22,7,NULL,7,1,'2019-03-20 01:30:00',NULL,0,'2019-03-20 01:30:31','2019-03-23 16:50:03','f8a814b9-f7f4-42ea-9142-5c973c978cd2'),(23,7,NULL,7,1,'2019-03-20 14:54:00',NULL,NULL,'2019-03-20 14:54:28','2019-04-04 04:46:43','86367255-8431-4ef4-b354-75e371f2faef'),(24,7,NULL,7,1,'2019-03-20 14:54:00',NULL,NULL,'2019-03-20 14:54:49','2019-04-04 04:46:43','4ce5042a-beb6-4d97-b430-55f0a5990177'),(28,7,NULL,7,1,'2019-03-23 17:33:00',NULL,NULL,'2019-03-23 17:33:14','2019-04-04 04:46:43','8b96e250-509c-49f5-a4bd-888b01b51b09'),(37,7,NULL,7,1,'2019-03-28 16:13:00',NULL,0,'2019-03-28 16:13:35','2019-03-28 16:13:35','00aebc29-b57d-454d-b771-d6b23b8c75c3'),(42,7,NULL,7,1,'2019-03-28 16:19:00',NULL,NULL,'2019-03-28 16:19:39','2019-04-04 04:46:43','75d19694-66ca-4805-b0fa-d8b50f6484ad'),(47,10,NULL,10,NULL,'2019-04-02 02:11:00',NULL,NULL,'2019-04-02 02:11:50','2019-04-04 04:40:58','a14dbd7b-ffdd-4c3e-ae07-90ae52250e7f'),(48,11,NULL,11,NULL,'2019-04-02 02:23:00',NULL,NULL,'2019-04-02 02:23:21','2019-04-04 04:38:00','ec3ea313-315a-4fca-b80e-b76cef783813'),(49,7,NULL,7,1,'2019-04-02 18:45:00',NULL,NULL,'2019-04-02 18:45:55','2019-04-04 04:46:43','205bdf33-b6e9-43a2-9791-74dea18dfd09');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrydrafts`
--

LOCK TABLES `entrydrafts` WRITE;
/*!40000 ALTER TABLE `entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,16,'Home Page','home_section',1,'Title','{section.name|raw}',1,'2019-03-12 22:00:30','2019-04-04 04:41:09',NULL,'d28dcdf2-fece-4f08-8997-be4605045f0d'),(2,2,NULL,'About','about',0,'','{section.name|raw}',1,'2019-03-12 22:00:42','2019-03-12 23:34:08','2019-04-02 02:10:16','6aed5380-e8b5-4c45-995a-47f9a633589b'),(3,3,NULL,'Contact','contact',0,NULL,'{section.name|raw}',1,'2019-03-12 22:01:04','2019-03-12 22:01:04','2019-04-02 02:10:18','f887a8ad-9bde-4e4e-8673-aa695050ca0f'),(4,4,NULL,'Topics Index','topics',0,NULL,'{section.name|raw}',1,'2019-03-12 22:01:10','2019-03-14 00:20:13','2019-03-20 01:31:24','cbba0623-bdb8-4393-ac02-3c66b164b3cd'),(5,5,NULL,'Login','login',0,NULL,'{section.name|raw}',1,'2019-03-12 22:01:17','2019-03-12 22:01:17','2019-04-02 02:10:20','9c990765-82ae-48ab-b61e-fbd52b601ece'),(6,6,NULL,'Search Results','searchResults',1,'Title',NULL,1,'2019-03-14 00:21:52','2019-03-14 00:21:52','2019-03-16 22:41:17','bda474c2-c7aa-44b1-b23e-551cd63797c3'),(7,7,8,'topics_entry_type','topics_entry_type',1,'Title','',1,'2019-03-16 19:08:07','2019-04-04 04:46:42',NULL,'729cad62-7474-495f-bd45-7de8bb49f42d'),(8,8,NULL,'Subtopics Index','subtopicsIndex',0,NULL,'{section.name|raw}',1,'2019-03-16 20:08:46','2019-03-16 20:08:46','2019-03-20 01:16:47','21a40dd6-5a85-4ff5-94cd-750b2c2482d6'),(9,9,NULL,'Topics/Subtopics Resources','topicsSubtopicsResources',1,'Title','',1,'2019-03-26 18:31:08','2019-03-26 18:32:18','2019-03-26 18:32:24','e7c2ebfa-3b1f-43a6-a551-0db04d5740ef'),(10,10,18,'About Page','about_index',0,'Title','About',1,'2019-04-02 02:11:19','2019-04-04 04:40:57',NULL,'ad1814ea-c8e3-4ce8-bcc8-f017f3f3bc45'),(11,11,17,'Topics - Index Page','topics_list',1,'List of All The AACI Topics','{section.name|raw}',1,'2019-04-02 02:23:21','2019-04-04 04:37:59',NULL,'f73d5627-97e9-4ce2-8239-72feadd13639');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entryversions`
--

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entryversions` VALUES (1,16,7,1,1,1,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Testing Subtopic\",\"slug\":\"testing-subtopic\",\"postDate\":1552764660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[\"15\"]}}','2019-03-16 19:31:41','2019-03-16 19:31:41','37468837-8dad-4fc9-ad09-a241468f24e9'),(2,17,7,1,1,1,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Testing Subtopic\",\"slug\":\"testing-subtopic\",\"postDate\":1552765380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[\"8\"]}}','2019-03-16 19:43:32','2019-03-16 19:43:32','42e4ccde-ff04-46b1-9bbf-08bb9e994669'),(3,19,7,1,1,1,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[]}}','2019-03-16 20:11:25','2019-03-16 20:11:25','37a778f8-2e25-4c48-bea1-f0868dcaf81a'),(4,19,7,1,1,2,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[\"8\",\"7\"]}}','2019-03-16 20:12:03','2019-03-16 20:12:03','ce4f19aa-6567-4ddc-af72-3e0320eab215'),(5,19,7,1,1,3,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity test\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[\"8\",\"7\"]}}','2019-03-20 01:07:51','2019-03-20 01:07:51','f9bccd90-ef44-4661-96d5-c53c7c65fa6a'),(6,19,7,1,1,4,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[\"8\",\"7\"]}}','2019-03-20 01:08:19','2019-03-20 01:08:19','845977f7-7ac0-43d8-9fba-d29b88ec76b5'),(7,19,7,1,1,5,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity test\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[\"8\",\"7\"]}}','2019-03-20 01:08:52','2019-03-20 01:08:52','f77594b9-6430-4524-a81d-e1c797b7d502'),(8,19,7,1,1,6,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[\"8\",\"7\"]}}','2019-03-20 01:11:07','2019-03-20 01:11:07','8dc38777-fa62-4344-a674-5b1039238899'),(9,19,7,1,1,7,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity tets\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[\"8\",\"7\"]}}','2019-03-20 01:15:01','2019-03-20 01:15:01','dd6e9d62-5959-41bd-a9d8-fde2d7002218'),(10,19,7,1,1,8,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity test\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[\"8\",\"7\"]}}','2019-03-20 01:15:05','2019-03-20 01:15:05','870f1195-48b4-43d5-9490-113a60d81275'),(11,19,7,1,1,9,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"13\":[\"8\",\"7\"]}}','2019-03-20 01:17:18','2019-03-20 01:17:18','cdffa5b2-a602-45cb-8bfe-c246610701fe'),(12,19,7,1,1,10,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"17\":[]}}','2019-03-20 01:24:38','2019-03-20 01:24:38','9f816474-52cc-4105-9477-aeb39c049d14'),(13,22,7,1,1,1,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"HPV Vaccination\",\"slug\":\"hpv-vaccination\",\"postDate\":1553045400,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"17\":[]}}','2019-03-20 01:30:31','2019-03-20 01:30:31','efabbd01-acfd-40a5-83e8-c74788d87676'),(14,23,7,1,1,1,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Test Subtopic (for HPV Topic)\",\"slug\":\"test-subtopic-for-hpv-topic\",\"postDate\":1553093640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"22\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"17\":[]}}','2019-03-20 14:54:28','2019-03-20 14:54:28','ae5216ec-632e-4e84-95aa-d9e05f7d1cce'),(15,24,7,1,1,1,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Test Subtopic 2 (for HPV topic)\",\"slug\":\"test-subtopic-2-for-hpv-topic\",\"postDate\":1553093640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"22\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"17\":[]}}','2019-03-20 14:54:49','2019-03-20 14:54:49','fe24e008-2fe3-46ee-8621-965f5cd0988d'),(16,28,7,1,1,1,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"HPV\",\"slug\":\"hpv\",\"postDate\":1553362380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"17\":[],\"20\":[]}}','2019-03-23 17:33:14','2019-03-23 17:33:14','3da65991-faef-43a6-960f-a0c6d646e9b7'),(17,24,7,1,1,2,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Test Subtopic 2 (for HPV topic)\",\"slug\":\"test-subtopic-2-for-hpv-topic\",\"postDate\":1553093640,\"expiryDate\":null,\"enabled\":false,\"newParentId\":\"28\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"17\":[],\"20\":[]}}','2019-03-23 17:33:23','2019-03-23 17:33:23','886a9d13-ba77-4654-a9d3-d4125dc6f97d'),(18,19,7,1,1,11,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"17\":[],\"19\":\"hello\",\"20\":[]}}','2019-03-23 20:14:32','2019-03-23 20:14:32','8b16db8a-4d88-4c44-926c-fda225752170'),(19,19,7,1,1,12,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"17\":[],\"19\":\"oral chemo descrip\",\"20\":[]}}','2019-03-23 20:15:53','2019-03-23 20:15:53','5eb750c2-4430-4302-879e-6c39f63b6200'),(20,28,7,1,1,2,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"HPV\",\"slug\":\"hpv\",\"postDate\":1553362380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"7\":[],\"8\":[],\"9\":[],\"11\":[],\"10\":[],\"17\":[],\"19\":\"hpv descrip\",\"20\":[]}}','2019-03-23 20:16:00','2019-03-23 20:16:00','bf70219a-a412-4474-8f9a-3f3ae0c8956a'),(21,23,7,1,1,2,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Test Subtopic (for HPV Topic)\",\"slug\":\"test-subtopic-for-hpv-topic\",\"postDate\":1553093640,\"expiryDate\":null,\"enabled\":false,\"newParentId\":\"28\",\"fields\":{\"21\":{\"30\":{\"type\":\"1\",\"fields\":{\"shortDescription2\":null,\"slogan2\":null,\"subtopicIcon\":[],\"requiredSubtopicTags\":[],\"optionalSubtopicTags\":[],\"subtopicResources\":[]}}}}}','2019-03-26 00:31:32','2019-03-26 00:31:32','007f709f-5b39-4e60-8d2c-f94cad5cb05f'),(22,19,7,1,1,13,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"35\":[],\"38\":[\"8\"]}}','2019-03-27 02:03:04','2019-03-27 02:03:04','62b73ac6-de12-49a3-b47b-48797d0327ef'),(23,37,7,1,1,1,NULL,'{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"fdf\",\"slug\":\"fdf\",\"postDate\":1553789580,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"35\":[],\"38\":[]}}','2019-03-28 16:13:36','2019-03-28 16:13:36','395efc20-0c65-443c-8f39-4adc19fb95f7'),(24,42,7,1,1,1,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"oral subtopic\",\"slug\":\"oral-subtopic\",\"postDate\":1553789940,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"19\",\"fields\":{\"35\":[],\"38\":[]}}','2019-03-28 16:19:39','2019-03-28 16:19:39','b4c6c21b-a508-4a4b-8f17-6ef7b61674a1'),(25,19,7,1,1,14,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemotherapy Parity\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":false,\"newParentId\":\"\",\"fields\":{\"35\":[],\"38\":[\"8\"]}}','2019-03-28 16:20:54','2019-03-28 16:20:54','816b0a49-7780-4360-894d-867d2b87d592'),(26,28,7,1,1,3,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"HPV\",\"slug\":\"hpv\",\"postDate\":1553362380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"35\":[],\"33\":\"Human Papilloma Virus Vaccination Advocacy blah blah\",\"34\":\"pls get vaccinated\",\"38\":[]}}','2019-03-29 19:33:42','2019-03-29 19:33:42','e2bc97dd-f7e4-4de3-8e9c-5c7a2eab9c4e'),(27,28,7,1,1,4,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"HPV\",\"slug\":\"hpv\",\"postDate\":1553362380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"35\":[],\"33\":\"Human Papilloma Virus Vaccination Advocacy blah blah\",\"34\":\"pls get vaccinated\",\"38\":[\"14\"]}}','2019-03-29 19:39:35','2019-03-29 19:39:35','8832570c-6f99-47ec-808a-891b55fb1800'),(28,2,1,1,1,1,'Revision from Apr 1, 2019, 7:08:39 PM','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1552428000,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":[]}','2019-04-02 02:09:16','2019-04-02 02:09:16','14efe823-c7e2-4410-bd50-59f3afae372a'),(29,2,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Cancer Resource Library\",\"slug\":\"home\",\"postDate\":1552428000,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2019-04-02 02:09:16','2019-04-02 02:09:16','d85f9740-7cc5-40c3-8f5c-a6fe6ad76a32'),(30,2,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1552428000,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2019-04-02 02:09:44','2019-04-02 02:09:44','3a5e7993-bc6d-406f-a991-fb4cb1afe01e'),(31,2,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Cancer Resource Library\",\"slug\":\"home\",\"postDate\":1552428000,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2019-04-02 02:15:19','2019-04-02 02:15:19','f5c0e374-49a2-4be1-b3f5-b8b291e06a38'),(32,47,10,1,1,1,'Revision from Apr 2, 2019, 10:30:35 AM','{\"typeId\":\"10\",\"authorId\":null,\"title\":\"About\",\"slug\":\"about\",\"postDate\":1554171060,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":[]}','2019-04-02 17:31:24','2019-04-02 17:31:24','6ffb5bc9-a22e-439e-9860-83686f15bfce'),(33,47,10,1,1,2,'','{\"typeId\":\"10\",\"authorId\":null,\"title\":\"About\",\"slug\":\"about\",\"postDate\":1554171060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"About This Resource Library\"}}','2019-04-02 17:31:25','2019-04-02 17:31:25','2642ad33-913f-4989-a789-9754adea8782'),(34,2,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1552428000,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"Cancer Resource Library\"}}','2019-04-02 17:33:34','2019-04-02 17:33:34','97588ae1-07d3-407c-8134-68a5b39156de'),(35,48,11,1,1,1,'Revision from Apr 2, 2019, 10:30:53 AM','{\"typeId\":\"11\",\"authorId\":null,\"title\":\"Topics Index\",\"slug\":\"topics-index\",\"postDate\":1554171780,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":[]}','2019-04-02 17:33:41','2019-04-02 17:33:41','a96a725a-8795-4016-b4dc-0f01925ac965'),(36,48,11,1,1,2,'','{\"typeId\":\"11\",\"authorId\":null,\"title\":\"Topics Index\",\"slug\":\"topics-index\",\"postDate\":1554171780,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"Topics\"}}','2019-04-02 17:33:41','2019-04-02 17:33:41','29a16e97-7724-4ba6-b00b-d740cf2abd8a'),(37,47,10,1,1,3,'','{\"typeId\":\"10\",\"authorId\":null,\"title\":\"About\",\"slug\":\"about\",\"postDate\":1554171060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"About Us\"}}','2019-04-02 17:34:42','2019-04-02 17:34:42','e6f06738-8ce2-4ddc-9b7b-3f1cce610dd3'),(38,28,7,1,1,5,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"HPV\",\"slug\":\"hpv\",\"postDate\":1553362380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"38\":[\"14\"],\"2\":\"HPV Vaccination\",\"35\":[],\"33\":\"Human Papilloma Virus Vaccination Advocacy blah blah\",\"34\":\"pls get vaccinated\"}}','2019-04-02 18:11:28','2019-04-02 18:11:28','452195bc-584f-4ad3-b52b-45e8fea05043'),(39,42,7,1,1,2,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"oral subtopic\",\"slug\":\"oral-subtopic\",\"postDate\":1553789940,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"19\",\"fields\":{\"38\":[],\"2\":\"oral subtopic heading\",\"35\":[]}}','2019-04-02 18:11:47','2019-04-02 18:11:47','efe95219-c064-43ea-891d-424417997702'),(40,19,7,1,1,15,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Oral Chemo\",\"slug\":\"oral-chemotherapy-parity\",\"postDate\":1552767060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"38\":[\"8\"],\"2\":\"Oral Chemotherapy Parity\",\"35\":[]}}','2019-04-02 18:12:01','2019-04-02 18:12:01','72ad72b6-acb3-4518-b6cf-37890074c8ab'),(41,49,7,1,1,1,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"Tobacco 21\",\"slug\":\"tobacco-21\",\"postDate\":1554230700,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"38\":[],\"2\":\"Tobacco 21\",\"35\":[]}}','2019-04-02 18:45:55','2019-04-02 18:45:55','f420ff56-8ce5-49db-a14f-3f14f8f79f95'),(42,28,7,1,1,6,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"HPV\",\"slug\":\"hpv\",\"postDate\":1553362380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"38\":[\"14\"],\"2\":\"HPV Vaccination\",\"35\":[\"50\"],\"33\":\"Human Papilloma Virus Vaccination Advocacy blah blah\",\"34\":\"pls get vaccinated\"}}','2019-04-02 19:20:22','2019-04-02 19:20:22','cdb15754-bd24-45ee-966d-35c3ac78b5b7'),(43,28,7,1,1,7,'','{\"typeId\":\"7\",\"authorId\":\"1\",\"title\":\"HPV\",\"slug\":\"hpv\",\"postDate\":1553362380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"38\":[\"14\"],\"2\":\"HPV Vaccination\",\"35\":[\"51\"],\"33\":\"Human Papilloma Virus Vaccination Advocacy blah blah\",\"34\":\"pls get vaccinated\"}}','2019-04-02 19:28:18','2019-04-02 19:28:18','405e5a7b-8eaa-465e-9bba-5324be841820');
/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'General','2019-03-02 20:01:21','2019-03-12 23:41:11','bd49d05a-3814-4821-bcf9-2aedfed2e879'),(2,'Homepage','2019-03-12 23:36:24','2019-03-12 23:36:24','f9beb7ff-1bba-4e77-845f-8a92691f87a7'),(8,'Topic/Subtopics','2019-03-14 00:23:25','2019-03-20 14:59:20','7aec1807-48f2-41c7-b821-83a622e4258f'),(9,'Tags','2019-03-16 19:05:21','2019-03-16 19:05:21','e5d0e74d-dd9e-4ae9-b4b2-5e347b915e8f');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (112,10,36,7,0,1,'2019-03-23 17:06:28','2019-03-23 17:06:28','22e46c4c-22d7-4b55-8f8e-0701e1c99e0f'),(152,12,48,11,0,1,'2019-03-26 00:35:31','2019-03-26 00:35:31','6b0bf8db-f9d9-4912-82bc-3d9e44ffa680'),(153,13,49,7,0,1,'2019-03-26 00:35:40','2019-03-26 00:35:40','b1a7d136-9d47-47c6-9568-565d6689e379'),(154,13,49,9,0,2,'2019-03-26 00:35:40','2019-03-26 00:35:40','53c6a207-079b-4153-b6e2-8ec23814e867'),(157,13,49,8,0,4,'2019-03-26 00:35:40','2019-03-26 00:35:40','8b6cfc56-cfa3-4fe4-a8fd-b3af6250db9f'),(207,1,66,33,0,1,'2019-03-26 12:13:23','2019-03-26 12:13:23','96f67c86-8e6d-4b91-a53e-87abe37d19ce'),(252,15,78,33,0,1,'2019-03-26 18:41:28','2019-03-26 18:41:28','9cb62093-c91b-41f4-acf3-a807c1467403'),(253,15,78,28,0,2,'2019-03-26 18:41:28','2019-03-26 18:41:28','3f1cb301-f44e-4f97-a928-669c141ce2a5'),(319,17,106,2,1,1,'2019-04-04 04:37:59','2019-04-04 04:37:59','399dc4c2-bf5c-484b-8b9a-078687ab9177'),(321,18,108,2,1,1,'2019-04-04 04:40:57','2019-04-04 04:40:57','f661d16b-ae21-4f9d-a8aa-0cd89e0880f6'),(322,16,109,2,1,1,'2019-04-04 04:41:09','2019-04-04 04:41:09','5a39f7b1-480e-4095-9e89-021c53045a6f'),(331,14,112,29,1,1,'2019-04-04 04:46:14','2019-04-04 04:46:14','1c7b83eb-9a18-42b8-b32f-48f64ffd6472'),(332,14,112,32,0,4,'2019-04-04 04:46:14','2019-04-04 04:46:14','85760cf0-4894-4967-8ff0-34260b9e2a77'),(333,14,112,30,0,2,'2019-04-04 04:46:14','2019-04-04 04:46:14','8f6abbe2-491b-4d62-9189-ac25f0cec5a0'),(334,14,112,31,0,3,'2019-04-04 04:46:14','2019-04-04 04:46:14','ccac311b-d3d2-44a0-b86f-13b0e862a98d'),(335,8,113,33,0,3,'2019-04-04 04:46:42','2019-04-04 04:46:42','076012fb-75a0-48ed-8f3b-c4ded1608d33'),(336,8,113,2,1,1,'2019-04-04 04:46:42','2019-04-04 04:46:42','1c572d20-ebd2-433b-8a6a-02535775ba1f'),(337,8,113,35,0,2,'2019-04-04 04:46:42','2019-04-04 04:46:42','0597cd65-5862-4ee1-9349-3404ef8a670c'),(338,8,113,34,0,4,'2019-04-04 04:46:42','2019-04-04 04:46:42','afb3d08e-4104-4707-8579-3d2a8006c7c8'),(339,8,113,38,0,5,'2019-04-04 04:46:42','2019-04-04 04:46:42','58618269-7e73-4a96-be5c-818f439a2cf0');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Tag','2019-03-14 04:46:50','2019-03-26 12:13:23',NULL,'14f2db13-e780-4939-a8d5-1d352f62dce9'),(2,'craft\\elements\\Tag','2019-03-14 04:46:56','2019-03-14 04:46:56','2019-03-16 19:00:12','06e0f33d-3155-446e-b5a4-cdb1696b1e85'),(3,'craft\\elements\\Tag','2019-03-14 04:47:07','2019-03-14 04:47:07','2019-03-16 19:00:16','6c048f9a-f15a-4ece-a78b-49bef94f8ad3'),(4,'craft\\elements\\Asset','2019-03-14 04:48:13','2019-03-16 19:05:29','2019-04-02 19:26:56','24338092-df26-48b3-8f9c-fa9416f26b27'),(5,'craft\\elements\\Asset','2019-03-14 04:48:48','2019-03-16 19:38:29','2019-03-17 21:03:02','c914f261-f045-433f-911a-62e02a1189ab'),(6,'craft\\elements\\Tag','2019-03-16 19:01:11','2019-03-16 19:05:29','2019-04-01 02:16:36','01057868-5f77-4424-8e4a-6fab1b1062db'),(7,'craft\\elements\\Tag','2019-03-16 19:06:05','2019-03-16 19:17:21','2019-04-01 02:17:22','61e7ad1c-5a5b-435a-ac8a-753902609cca'),(8,'craft\\elements\\Entry','2019-03-16 19:30:31','2019-04-04 04:46:42',NULL,'0eeebb26-5582-45bc-94b8-c53afd5dec24'),(9,'craft\\elements\\Category','2019-03-20 01:09:35','2019-03-20 01:09:35','2019-03-20 01:10:58','d57c93bf-c115-4972-bcb9-4eaee1e09eb3'),(10,'craft\\elements\\Asset','2019-03-23 17:06:28','2019-03-23 17:06:28','2019-03-26 12:13:45','f85c8166-e03c-4c6d-b86b-8d92af4d923c'),(11,'verbb\\supertable\\elements\\SuperTableBlockElement','2019-03-25 16:29:50','2019-03-26 00:55:16','2019-03-26 00:55:20','5a01ebee-be97-4555-855c-062c183c1dad'),(12,'craft\\elements\\Tag','2019-03-25 16:40:14','2019-03-26 00:35:31','2019-03-26 00:37:43','f1a8d036-86f3-443e-95c5-855cf576d29b'),(13,'craft\\elements\\Tag','2019-03-25 16:40:39','2019-03-26 00:35:40','2019-03-26 00:37:46','e48db2cf-90a8-4418-841d-41802e56c8e0'),(14,'verbb\\supertable\\elements\\SuperTableBlockElement','2019-03-26 00:43:58','2019-04-04 04:46:14',NULL,'6185ca10-51a0-432f-bbc2-44ec6ed400ab'),(15,'craft\\elements\\Asset','2019-03-26 12:14:19','2019-03-26 18:41:27',NULL,'4e5a5859-199e-4487-af13-9869b3a713d2'),(16,'craft\\elements\\Entry','2019-04-02 17:23:10','2019-04-04 04:41:09',NULL,'4711eda5-f6b1-4a0f-9292-752e23d80424'),(17,'craft\\elements\\Entry','2019-04-02 17:23:35','2019-04-04 04:37:59',NULL,'88d9e27f-a3e2-406f-b2ef-47da2f72ed51'),(18,'craft\\elements\\Entry','2019-04-02 17:24:09','2019-04-04 04:40:57',NULL,'64cd9903-ea4f-469a-a59d-b6721a893839');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (2,2,'Content',1,'2019-03-14 04:46:56','2019-03-14 04:46:56','7723cea6-e851-4d88-b606-3c957680bdc4'),(3,3,'Content',1,'2019-03-14 04:47:07','2019-03-14 04:47:07','2b80ddb5-7227-42d8-91c7-337ef5418d30'),(8,4,'Content',1,'2019-03-16 19:05:29','2019-03-16 19:05:29','285ef09c-6977-4bf2-8765-523191d70e60'),(10,6,'Content',1,'2019-03-16 19:05:29','2019-03-16 19:05:29','4f7040bc-5111-4e91-8126-81a05b417a20'),(14,7,'Content',1,'2019-03-16 19:17:21','2019-03-16 19:17:21','ba0a7494-378d-4b16-badf-32578ee7ed01'),(21,5,'Content',1,'2019-03-16 19:38:29','2019-03-16 19:38:29','1bf72855-e716-452c-9ea2-47c2cdc94c18'),(25,9,'Content',1,'2019-03-20 01:09:35','2019-03-20 01:09:35','bdea5ac1-193c-4a2b-984c-63a6dad8f855'),(36,10,'Content',1,'2019-03-23 17:06:28','2019-03-23 17:06:28','e30dc98a-9679-49d4-a7f7-a6b3119d91f4'),(48,12,'Content',1,'2019-03-26 00:35:31','2019-03-26 00:35:31','d8fd1555-bfc1-453d-8300-23caef62a47e'),(49,13,'Content',1,'2019-03-26 00:35:40','2019-03-26 00:35:40','18b6d812-a30a-4f11-ac28-b7d5f544b5c2'),(64,11,'Content',1,'2019-03-26 00:55:16','2019-03-26 00:55:16','b26714fb-1c56-4e43-8a2e-abf9212e943a'),(66,1,'Content',1,'2019-03-26 12:13:23','2019-03-26 12:13:23','3b8e9a76-47dd-4253-ba96-720058139e05'),(78,15,'Content',1,'2019-03-26 18:41:28','2019-03-26 18:41:28','3b9abf1a-36dc-4128-ae25-1a9a3f7b34fb'),(106,17,'Content',1,'2019-04-04 04:37:59','2019-04-04 04:37:59','ca11e9f5-a37b-461a-a662-03c95572f64a'),(108,18,'Content',1,'2019-04-04 04:40:57','2019-04-04 04:40:57','33016ddc-5e4a-42a4-afc1-70da345eb007'),(109,16,'Content',1,'2019-04-04 04:41:09','2019-04-04 04:41:09','d1a8a458-d809-4a4a-95ea-e81658fc42fa'),(112,14,'Content',1,'2019-04-04 04:46:14','2019-04-04 04:46:14','9fa601ea-4111-4fe2-8b00-9aaf0107cb71'),(113,8,'Content',1,'2019-04-04 04:46:42','2019-04-04 04:46:42','3f5ae78b-ee35-45d7-9ce1-cc8c3135bc76');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (1,2,'clientLogos','clientlogos','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"}','2019-03-12 23:38:11','2019-03-12 23:38:16','5859f2ae-a21b-45b2-8f44-f8e7a8fefd31'),(2,1,'Heading','heading','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"This will show at the top of the page.\"}','2019-03-14 00:16:39','2019-04-02 17:22:13','a45974e5-3976-47ad-8022-b97e2e2b7e46'),(7,9,'Content Category Tag','contentCategoryTagField','global','',1,'site',NULL,'craft\\fields\\Tags','{\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"taggroup:f870fcf5-c00e-4116-8119-beb68daab851\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null}','2019-03-16 19:25:46','2019-03-25 16:22:48','2d6b8162-e845-4685-ab5e-97cb427833a1'),(8,9,'File Type Tag','fileTypeTagField','global','',1,'site',NULL,'craft\\fields\\Tags','{\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"taggroup:d9eafeb5-1a3b-41cd-9ca3-6f880f1a131d\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null}','2019-03-16 19:26:00','2019-03-26 12:12:30','fc50edbb-828e-4f6e-96a2-2f1e988d8ee9'),(9,9,'Institution Tag','institutionTagField','global','',1,'site',NULL,'craft\\fields\\Tags','{\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"taggroup:3cf0a51d-6681-4ef9-a9d2-827f9e0ed36a\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null}','2019-03-16 19:26:13','2019-03-16 19:36:49','3520c4c3-1f26-49ea-bd54-ccfd77995a8c'),(11,9,'Location State Tag','locationStateTagField','global','',1,'site',NULL,'craft\\fields\\Tags','{\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"taggroup:5fd43216-4949-46d6-a2c5-07b661977ab1\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null}','2019-03-16 19:26:42','2019-03-16 19:36:55','4e8f10fd-629a-44d9-a227-a25cd1e0cdd1'),(28,8,'Resource Tags','resourceTagsField','global','',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"columns\":{\"29\":{\"width\":\"\"},\"30\":{\"width\":\"\"},\"31\":{\"width\":\"\"},\"32\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_resourcetagsfield}}\",\"fieldLayout\":\"row\",\"localizeBlocks\":false,\"maxRows\":\"\",\"minRows\":\"\",\"selectionLabel\":\"\",\"staticField\":\"1\"}','2019-03-26 00:43:57','2019-04-04 04:46:14','820ecbe8-2ac2-4a00-84a9-dd4a5331d6fe'),(29,NULL,'State Tag','stateTagField','superTableBlockType:b87e3609-07d3-4f8d-b014-02d43c1b7e6b','',1,'site',NULL,'craft\\fields\\Tags','{\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"taggroup:5fd43216-4949-46d6-a2c5-07b661977ab1\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null}','2019-03-26 00:43:58','2019-04-04 04:46:14','2a23569a-a1d0-4191-bed6-fc858f3b4bb2'),(30,NULL,'Content Tag','contentTagField','superTableBlockType:b87e3609-07d3-4f8d-b014-02d43c1b7e6b','',1,'site',NULL,'craft\\fields\\Tags','{\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"taggroup:f870fcf5-c00e-4116-8119-beb68daab851\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null}','2019-03-26 00:43:58','2019-04-04 04:46:14','81a65cb5-3e61-4703-9956-f476c8a6ea05'),(31,NULL,'File Type Tag','fileTypeTagField','superTableBlockType:b87e3609-07d3-4f8d-b014-02d43c1b7e6b','',1,'site',NULL,'craft\\fields\\Tags','{\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"taggroup:d9eafeb5-1a3b-41cd-9ca3-6f880f1a131d\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null}','2019-03-26 00:47:43','2019-04-04 04:46:14','94cc11fa-8674-4f16-a557-280a339f59f8'),(32,NULL,'Institution Tag','institutionTagField','superTableBlockType:b87e3609-07d3-4f8d-b014-02d43c1b7e6b','',1,'site',NULL,'craft\\fields\\Tags','{\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"taggroup:3cf0a51d-6681-4ef9-a9d2-827f9e0ed36a\",\"sources\":\"*\",\"targetSiteId\":null,\"viewMode\":null}','2019-03-26 00:48:02','2019-04-04 04:46:14','481a06cd-7b7b-4896-b424-92f974707d75'),(33,1,'Short Description','shortDescription','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"Enter the the short description.\"}','2019-03-26 00:50:12','2019-03-27 02:03:51','0e50d7a7-a7e6-44a5-93b4-c81eff229a26'),(34,1,'Slogan','slogan','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"Enter the slogan\"}','2019-03-26 00:50:24','2019-03-26 00:50:24','b782df66-c05d-4de6-be7b-963cc07585d5'),(35,8,'Icon','icon','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:14a5170c-9eed-42d3-a7e7-103749b44e85\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Choose an icon.\",\"singleUploadLocationSource\":\"volume:af5d9f4c-8370-4936-b18f-2656c9900a8d\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:af5d9f4c-8370-4936-b18f-2656c9900a8d\"],\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"}','2019-03-26 00:56:04','2019-04-02 19:27:56','af0c2fba-82a5-4eb5-860f-606d34e9ee17'),(38,8,'Documents','documents','global','After adding an asset, double click on it for its information.',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:c9fb2884-b316-47b8-8ee1-8c13739b99cb\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"volume:c9fb2884-b316-47b8-8ee1-8c13739b99cb\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:c9fb2884-b316-47b8-8ee1-8c13739b99cb\"],\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"large\"}','2019-03-26 18:40:30','2019-03-30 18:37:23','f9540f2f-94dc-4496-bb78-51b9dde2a76f');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.1.15','3.1.25',0,'a:14:{s:14:\"categoryGroups\";a:1:{s:36:\"9daf7b14-27fe-44c5-a796-bd88508685be\";a:4:{s:6:\"handle\";s:10:\"topicsTest\";s:4:\"name\";s:11:\"Topics test\";s:12:\"siteSettings\";a:1:{s:36:\"06419039-5941-41b4-a10b-a0003a4a0a8a\";a:3:{s:7:\"hasUrls\";b:1;s:8:\"template\";s:0:\"\";s:9:\"uriFormat\";s:18:\"topics-test/{slug}\";}}s:9:\"structure\";a:2:{s:9:\"maxLevels\";N;s:3:\"uid\";s:36:\"f86a74ca-7e91-4e78-8af6-452451af6d4a\";}}}s:12:\"dateModified\";i:1554668544;s:5:\"email\";a:5:{s:9:\"fromEmail\";s:21:\"egiuse@andrew.cmu.edu\";s:8:\"fromName\";s:12:\"Craft3manual\";s:8:\"template\";s:0:\"\";s:17:\"transportSettings\";N;s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:11:\"fieldGroups\";a:4:{s:36:\"7aec1807-48f2-41c7-b821-83a622e4258f\";a:1:{s:4:\"name\";s:15:\"Topic/Subtopics\";}s:36:\"bd49d05a-3814-4821-bcf9-2aedfed2e879\";a:1:{s:4:\"name\";s:7:\"General\";}s:36:\"e5d0e74d-dd9e-4ae9-b4b2-5e347b915e8f\";a:1:{s:4:\"name\";s:4:\"Tags\";}s:36:\"f9beb7ff-1bba-4e77-845f-8a92691f87a7\";a:1:{s:4:\"name\";s:8:\"Homepage\";}}s:6:\"fields\";a:11:{s:36:\"0e50d7a7-a7e6-44a5-93b4-c81eff229a26\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"bd49d05a-3814-4821-bcf9-2aedfed2e879\";s:6:\"handle\";s:16:\"shortDescription\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:17:\"Short Description\";s:10:\"searchable\";b:1;s:8:\"settings\";a:6:{s:9:\"charLimit\";s:0:\"\";s:4:\"code\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";s:11:\"initialRows\";s:1:\"4\";s:9:\"multiline\";s:0:\"\";s:11:\"placeholder\";s:32:\"Enter the the short description.\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:22:\"craft\\fields\\PlainText\";}s:36:\"2d6b8162-e845-4685-ab5e-97cb427833a1\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"e5d0e74d-dd9e-4ae9-b4b2-5e347b915e8f\";s:6:\"handle\";s:23:\"contentCategoryTagField\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:20:\"Content Category Tag\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:5:\"limit\";N;s:17:\"localizeRelations\";b:0;s:14:\"selectionLabel\";s:0:\"\";s:6:\"source\";s:45:\"taggroup:f870fcf5-c00e-4116-8119-beb68daab851\";s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:17:\"craft\\fields\\Tags\";}s:36:\"3520c4c3-1f26-49ea-bd54-ccfd77995a8c\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"e5d0e74d-dd9e-4ae9-b4b2-5e347b915e8f\";s:6:\"handle\";s:19:\"institutionTagField\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:15:\"Institution Tag\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:5:\"limit\";N;s:17:\"localizeRelations\";b:0;s:14:\"selectionLabel\";s:0:\"\";s:6:\"source\";s:45:\"taggroup:3cf0a51d-6681-4ef9-a9d2-827f9e0ed36a\";s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:17:\"craft\\fields\\Tags\";}s:36:\"4e8f10fd-629a-44d9-a227-a25cd1e0cdd1\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"e5d0e74d-dd9e-4ae9-b4b2-5e347b915e8f\";s:6:\"handle\";s:21:\"locationStateTagField\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:18:\"Location State Tag\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:5:\"limit\";N;s:17:\"localizeRelations\";b:0;s:14:\"selectionLabel\";s:0:\"\";s:6:\"source\";s:45:\"taggroup:5fd43216-4949-46d6-a2c5-07b661977ab1\";s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:17:\"craft\\fields\\Tags\";}s:36:\"5859f2ae-a21b-45b2-8f44-f8e7a8fefd31\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"f9beb7ff-1bba-4e77-845f-8a92691f87a7\";s:6:\"handle\";s:11:\"clientlogos\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:11:\"clientLogos\";s:10:\"searchable\";b:1;s:8:\"settings\";a:14:{s:12:\"allowedKinds\";N;s:27:\"defaultUploadLocationSource\";s:0:\"\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:5:\"limit\";s:0:\"\";s:17:\"localizeRelations\";b:0;s:13:\"restrictFiles\";s:0:\"\";s:14:\"selectionLabel\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:0:\"\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:6:\"source\";N;s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:15:\"useSingleFolder\";s:0:\"\";s:8:\"viewMode\";s:5:\"large\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Assets\";}s:36:\"820ecbe8-2ac2-4a00-84a9-dd4a5331d6fe\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"7aec1807-48f2-41c7-b821-83a622e4258f\";s:6:\"handle\";s:17:\"resourceTagsField\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:13:\"Resource Tags\";s:10:\"searchable\";b:1;s:8:\"settings\";a:8:{s:7:\"columns\";a:4:{i:29;a:1:{s:5:\"width\";s:0:\"\";}i:30;a:1:{s:5:\"width\";s:0:\"\";}i:31;a:1:{s:5:\"width\";s:0:\"\";}i:32;a:1:{s:5:\"width\";s:0:\"\";}}s:12:\"contentTable\";s:26:\"{{%stc_resourcetagsfield}}\";s:11:\"fieldLayout\";s:3:\"row\";s:14:\"localizeBlocks\";b:0;s:7:\"maxRows\";s:0:\"\";s:7:\"minRows\";s:0:\"\";s:14:\"selectionLabel\";s:0:\"\";s:11:\"staticField\";s:1:\"1\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:39:\"verbb\\supertable\\fields\\SuperTableField\";}s:36:\"a45974e5-3976-47ad-8022-b97e2e2b7e46\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"bd49d05a-3814-4821-bcf9-2aedfed2e879\";s:6:\"handle\";s:7:\"heading\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:7:\"Heading\";s:10:\"searchable\";b:1;s:8:\"settings\";a:6:{s:9:\"charLimit\";s:0:\"\";s:4:\"code\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";s:11:\"initialRows\";s:1:\"4\";s:9:\"multiline\";s:0:\"\";s:11:\"placeholder\";s:38:\"This will show at the top of the page.\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:22:\"craft\\fields\\PlainText\";}s:36:\"af0c2fba-82a5-4eb5-860f-606d34e9ee17\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"7aec1807-48f2-41c7-b821-83a622e4258f\";s:6:\"handle\";s:4:\"icon\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:4:\"Icon\";s:10:\"searchable\";b:1;s:8:\"settings\";a:14:{s:12:\"allowedKinds\";N;s:27:\"defaultUploadLocationSource\";s:43:\"volume:14a5170c-9eed-42d3-a7e7-103749b44e85\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:5:\"limit\";s:1:\"1\";s:17:\"localizeRelations\";b:0;s:13:\"restrictFiles\";s:0:\"\";s:14:\"selectionLabel\";s:15:\"Choose an icon.\";s:26:\"singleUploadLocationSource\";s:43:\"volume:af5d9f4c-8370-4936-b18f-2656c9900a8d\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:6:\"source\";N;s:7:\"sources\";a:1:{i:0;s:43:\"volume:af5d9f4c-8370-4936-b18f-2656c9900a8d\";}s:12:\"targetSiteId\";N;s:15:\"useSingleFolder\";s:0:\"\";s:8:\"viewMode\";s:5:\"large\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Assets\";}s:36:\"b782df66-c05d-4de6-be7b-963cc07585d5\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"bd49d05a-3814-4821-bcf9-2aedfed2e879\";s:6:\"handle\";s:6:\"slogan\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:6:\"Slogan\";s:10:\"searchable\";b:1;s:8:\"settings\";a:6:{s:9:\"charLimit\";s:0:\"\";s:4:\"code\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";s:11:\"initialRows\";s:1:\"4\";s:9:\"multiline\";s:0:\"\";s:11:\"placeholder\";s:16:\"Enter the slogan\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:22:\"craft\\fields\\PlainText\";}s:36:\"f9540f2f-94dc-4496-bb78-51b9dde2a76f\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"7aec1807-48f2-41c7-b821-83a622e4258f\";s:6:\"handle\";s:9:\"documents\";s:12:\"instructions\";s:62:\"After adding an asset, double click on it for its information.\";s:4:\"name\";s:9:\"Documents\";s:10:\"searchable\";b:1;s:8:\"settings\";a:14:{s:12:\"allowedKinds\";N;s:27:\"defaultUploadLocationSource\";s:43:\"volume:c9fb2884-b316-47b8-8ee1-8c13739b99cb\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:5:\"limit\";s:0:\"\";s:17:\"localizeRelations\";b:0;s:13:\"restrictFiles\";s:0:\"\";s:14:\"selectionLabel\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:c9fb2884-b316-47b8-8ee1-8c13739b99cb\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:6:\"source\";N;s:7:\"sources\";a:1:{i:0;s:43:\"volume:c9fb2884-b316-47b8-8ee1-8c13739b99cb\";}s:12:\"targetSiteId\";N;s:15:\"useSingleFolder\";s:0:\"\";s:8:\"viewMode\";s:5:\"large\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Assets\";}s:36:\"fc50edbb-828e-4f6e-96a2-2f1e988d8ee9\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"e5d0e74d-dd9e-4ae9-b4b2-5e347b915e8f\";s:6:\"handle\";s:16:\"fileTypeTagField\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:13:\"File Type Tag\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:5:\"limit\";N;s:17:\"localizeRelations\";b:0;s:14:\"selectionLabel\";s:0:\"\";s:6:\"source\";s:45:\"taggroup:d9eafeb5-1a3b-41cd-9ca3-6f880f1a131d\";s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:17:\"craft\\fields\\Tags\";}}s:7:\"plugins\";a:10:{s:8:\"child-me\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:6:\"cp-css\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"2.0.0\";}s:16:\"cp-field-inspect\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:6:\"cp-nav\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"2.0.0\";}s:14:\"embeddedassets\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:16:\"expanded-singles\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:13:\"field-manager\";a:4:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";s:8:\"settings\";a:1:{s:16:\"cpSectionEnabled\";s:0:\"\";}}s:8:\"redactor\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"2.2.2\";}s:11:\"super-table\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:6:\"2.0.10\";}s:11:\"tag-manager\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}}s:8:\"sections\";a:4:{s:36:\"3323900d-bc90-4c77-8638-89fe3d9baaa1\";a:7:{s:16:\"enableVersioning\";b:1;s:10:\"entryTypes\";a:1:{s:36:\"d28dcdf2-fece-4f08-8997-be4605045f0d\";a:7:{s:12:\"fieldLayouts\";a:1:{s:36:\"4711eda5-f6b1-4a0f-9292-752e23d80424\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:1:{s:36:\"a45974e5-3976-47ad-8022-b97e2e2b7e46\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";}}}}s:6:\"handle\";s:12:\"home_section\";s:13:\"hasTitleField\";s:1:\"1\";s:4:\"name\";s:9:\"Home Page\";s:9:\"sortOrder\";i:1;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:10:\"titleLabel\";s:5:\"Title\";}}s:6:\"handle\";s:10:\"home_index\";s:4:\"name\";s:9:\"Home Page\";s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"06419039-5941-41b4-a10b-a0003a4a0a8a\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:8:\"template\";s:4:\"home\";s:9:\"uriFormat\";s:8:\"__home__\";}}s:4:\"type\";s:6:\"single\";}s:36:\"467a7187-2226-4c46-bcc4-3b390493f66a\";a:7:{s:16:\"enableVersioning\";b:1;s:10:\"entryTypes\";a:1:{s:36:\"f73d5627-97e9-4ce2-8239-72feadd13639\";a:7:{s:12:\"fieldLayouts\";a:1:{s:36:\"88d9e27f-a3e2-406f-b2ef-47da2f72ed51\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:1:{s:36:\"a45974e5-3976-47ad-8022-b97e2e2b7e46\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";}}}}s:6:\"handle\";s:11:\"topics_list\";s:13:\"hasTitleField\";s:1:\"1\";s:4:\"name\";s:19:\"Topics - Index Page\";s:9:\"sortOrder\";i:1;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:10:\"titleLabel\";s:27:\"List of All The AACI Topics\";}}s:6:\"handle\";s:12:\"topics_index\";s:4:\"name\";s:19:\"Topics - Index Page\";s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"06419039-5941-41b4-a10b-a0003a4a0a8a\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:8:\"template\";s:12:\"topics_index\";s:9:\"uriFormat\";s:7:\"/topics\";}}s:4:\"type\";s:6:\"single\";}s:36:\"6bf6ecfb-cd83-47f9-8c99-d75b4e1b9b89\";a:7:{s:16:\"enableVersioning\";b:1;s:10:\"entryTypes\";a:1:{s:36:\"ad1814ea-c8e3-4ce8-bcc8-f017f3f3bc45\";a:7:{s:12:\"fieldLayouts\";a:1:{s:36:\"64cd9903-ea4f-469a-a59d-b6721a893839\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:1:{s:36:\"a45974e5-3976-47ad-8022-b97e2e2b7e46\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";}}}}s:6:\"handle\";s:11:\"about_index\";s:13:\"hasTitleField\";s:1:\"0\";s:4:\"name\";s:10:\"About Page\";s:9:\"sortOrder\";i:1;s:11:\"titleFormat\";s:5:\"About\";s:10:\"titleLabel\";s:5:\"Title\";}}s:6:\"handle\";s:11:\"about_index\";s:4:\"name\";s:10:\"About Page\";s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"06419039-5941-41b4-a10b-a0003a4a0a8a\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:8:\"template\";s:5:\"about\";s:9:\"uriFormat\";s:6:\"/about\";}}s:4:\"type\";s:6:\"single\";}s:36:\"c469a882-e929-4b33-9e7b-bea1c720755e\";a:8:{s:16:\"enableVersioning\";b:1;s:10:\"entryTypes\";a:1:{s:36:\"729cad62-7474-495f-bd45-7de8bb49f42d\";a:7:{s:12:\"fieldLayouts\";a:1:{s:36:\"0eeebb26-5582-45bc-94b8-c53afd5dec24\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:5:{s:36:\"0e50d7a7-a7e6-44a5-93b4-c81eff229a26\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"a45974e5-3976-47ad-8022-b97e2e2b7e46\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"af0c2fba-82a5-4eb5-860f-606d34e9ee17\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"b782df66-c05d-4de6-be7b-963cc07585d5\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"f9540f2f-94dc-4496-bb78-51b9dde2a76f\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"handle\";s:17:\"topics_entry_type\";s:13:\"hasTitleField\";b:1;s:4:\"name\";s:17:\"topics_entry_type\";s:9:\"sortOrder\";i:1;s:11:\"titleFormat\";s:0:\"\";s:10:\"titleLabel\";s:5:\"Title\";}}s:6:\"handle\";s:10:\"all_topics\";s:4:\"name\";s:17:\"Topic - Show Page\";s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"06419039-5941-41b4-a10b-a0003a4a0a8a\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:8:\"template\";s:10:\"topic_show\";s:9:\"uriFormat\";s:19:\"{parent.uri}/{slug}\";}}s:9:\"structure\";a:2:{s:9:\"maxLevels\";s:0:\"\";s:3:\"uid\";s:36:\"1cdb4495-063e-48df-b0e9-31f4b275d062\";}s:4:\"type\";s:9:\"structure\";}}s:10:\"siteGroups\";a:1:{s:36:\"36f6937e-673b-4f31-845c-d37b7f19de90\";a:1:{s:4:\"name\";s:12:\"Craft3manual\";}}s:5:\"sites\";a:1:{s:36:\"06419039-5941-41b4-a10b-a0003a4a0a8a\";a:8:{s:7:\"baseUrl\";s:17:\"$DEFAULT_SITE_URL\";s:6:\"handle\";s:7:\"default\";s:7:\"hasUrls\";b:1;s:8:\"language\";s:5:\"en-US\";s:4:\"name\";s:12:\"Craft3manual\";s:7:\"primary\";b:1;s:9:\"siteGroup\";s:36:\"36f6937e-673b-4f31-845c-d37b7f19de90\";s:9:\"sortOrder\";i:1;}}s:20:\"superTableBlockTypes\";a:1:{s:36:\"b87e3609-07d3-4f8d-b014-02d43c1b7e6b\";a:3:{s:5:\"field\";s:36:\"820ecbe8-2ac2-4a00-84a9-dd4a5331d6fe\";s:12:\"fieldLayouts\";a:1:{s:36:\"6185ca10-51a0-432f-bbc2-44ec6ed400ab\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:4:{s:36:\"2a23569a-a1d0-4191-bed6-fc858f3b4bb2\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"481a06cd-7b7b-4896-b424-92f974707d75\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"81a65cb5-3e61-4703-9956-f476c8a6ea05\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"94cc11fa-8674-4f16-a557-280a339f59f8\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"fields\";a:4:{s:36:\"2a23569a-a1d0-4191-bed6-fc858f3b4bb2\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:13:\"stateTagField\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:9:\"State Tag\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:5:\"limit\";N;s:17:\"localizeRelations\";b:0;s:14:\"selectionLabel\";s:0:\"\";s:6:\"source\";s:45:\"taggroup:5fd43216-4949-46d6-a2c5-07b661977ab1\";s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:17:\"craft\\fields\\Tags\";}s:36:\"481a06cd-7b7b-4896-b424-92f974707d75\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:19:\"institutionTagField\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:15:\"Institution Tag\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:5:\"limit\";N;s:17:\"localizeRelations\";b:0;s:14:\"selectionLabel\";s:0:\"\";s:6:\"source\";s:45:\"taggroup:3cf0a51d-6681-4ef9-a9d2-827f9e0ed36a\";s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:17:\"craft\\fields\\Tags\";}s:36:\"81a65cb5-3e61-4703-9956-f476c8a6ea05\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:15:\"contentTagField\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:11:\"Content Tag\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:5:\"limit\";N;s:17:\"localizeRelations\";b:0;s:14:\"selectionLabel\";s:0:\"\";s:6:\"source\";s:45:\"taggroup:f870fcf5-c00e-4116-8119-beb68daab851\";s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:17:\"craft\\fields\\Tags\";}s:36:\"94cc11fa-8674-4f16-a557-280a339f59f8\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:16:\"fileTypeTagField\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:13:\"File Type Tag\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:5:\"limit\";N;s:17:\"localizeRelations\";b:0;s:14:\"selectionLabel\";s:0:\"\";s:6:\"source\";s:45:\"taggroup:d9eafeb5-1a3b-41cd-9ca3-6f880f1a131d\";s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:17:\"craft\\fields\\Tags\";}}}}s:6:\"system\";a:5:{s:7:\"edition\";s:3:\"pro\";s:4:\"live\";b:1;s:4:\"name\";s:12:\"AACI Library\";s:13:\"schemaVersion\";s:6:\"3.1.25\";s:8:\"timeZone\";s:19:\"America/Los_Angeles\";}s:9:\"tagGroups\";a:5:{s:36:\"3cf0a51d-6681-4ef9-a9d2-827f9e0ed36a\";a:2:{s:6:\"handle\";s:11:\"institution\";s:4:\"name\";s:11:\"Institution\";}s:36:\"5fd43216-4949-46d6-a2c5-07b661977ab1\";a:2:{s:6:\"handle\";s:13:\"documentState\";s:4:\"name\";s:5:\"State\";}s:36:\"d9eafeb5-1a3b-41cd-9ca3-6f880f1a131d\";a:3:{s:12:\"fieldLayouts\";a:1:{s:36:\"14f2db13-e780-4939-a8d5-1d352f62dce9\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:1:{s:36:\"0e50d7a7-a7e6-44a5-93b4-c81eff229a26\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"handle\";s:8:\"fileType\";s:4:\"name\";s:9:\"File Type\";}s:36:\"f2cd8507-090e-414c-b6ea-fb24c7120ee9\";a:2:{s:6:\"handle\";s:13:\"documentTitle\";s:4:\"name\";s:5:\"Title\";}s:36:\"f870fcf5-c00e-4116-8119-beb68daab851\";a:2:{s:6:\"handle\";s:15:\"documentContent\";s:4:\"name\";s:7:\"Content\";}}s:5:\"users\";a:5:{s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:12:\"photoSubpath\";s:0:\"\";s:14:\"photoVolumeUid\";N;s:24:\"requireEmailVerification\";b:1;}s:7:\"volumes\";a:3:{s:36:\"14a5170c-9eed-42d3-a7e7-103749b44e85\";a:7:{s:6:\"handle\";s:13:\"subtopicIcons\";s:7:\"hasUrls\";b:0;s:4:\"name\";s:14:\"Subtopic Icons\";s:8:\"settings\";a:1:{s:4:\"path\";s:36:\"@webroot/assets/icons/subtopic-icons\";}s:9:\"sortOrder\";s:1:\"2\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:3:\"url\";s:0:\"\";}s:36:\"af5d9f4c-8370-4936-b18f-2656c9900a8d\";a:7:{s:6:\"handle\";s:10:\"topicIcons\";s:7:\"hasUrls\";b:1;s:4:\"name\";s:11:\"Topic Icons\";s:8:\"settings\";a:1:{s:4:\"path\";s:31:\"@webroot/assets/img/topic-icons\";}s:9:\"sortOrder\";s:1:\"1\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:3:\"url\";s:23:\"/assets/img/topic-icons\";}s:36:\"c9fb2884-b316-47b8-8ee1-8c13739b99cb\";a:8:{s:12:\"fieldLayouts\";a:1:{s:36:\"4e5a5859-199e-4487-af13-9869b3a713d2\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:2:{s:36:\"0e50d7a7-a7e6-44a5-93b4-c81eff229a26\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"820ecbe8-2ac2-4a00-84a9-dd4a5331d6fe\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"handle\";s:9:\"resources\";s:7:\"hasUrls\";b:0;s:4:\"name\";s:9:\"Resources\";s:8:\"settings\";a:1:{s:4:\"path\";s:25:\"@webroot/assets/resources\";}s:9:\"sortOrder\";s:1:\"7\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:3:\"url\";s:0:\"\";}}}','{\"categoryGroups\":\"@config/project.yaml\",\"dateModified\":\"@config/project.yaml\",\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"fields\":\"@config/project.yaml\",\"plugins\":\"@config/project.yaml\",\"sections\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"tagGroups\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\",\"volumes\":\"@config/project.yaml\",\"superTableBlockTypes\":\"@config/project.yaml\"}','Modbq8rC4pgX','2019-03-02 20:01:20','2019-04-07 20:22:24','11d60b78-a155-41b4-94ef-c0096ef93dc5');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','2d48f66a-a959-49ef-abdf-2d5038ef278b'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','29b3dc38-fc5c-4e6f-b553-ca70fcab12ef'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','3f7bed08-78b3-4bb7-a16e-441031f42386'),(4,NULL,'app','m150403_184533_field_version','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','084b7f09-5fd7-4b77-8938-5a3289972d35'),(5,NULL,'app','m150403_184729_type_columns','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','2dfbdcce-c968-4b01-a5f5-82aa974ff0a2'),(6,NULL,'app','m150403_185142_volumes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','6944942e-abe2-455b-b064-092d1935f3ad'),(7,NULL,'app','m150428_231346_userpreferences','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','caff53bc-252b-467d-9de9-c38d249b4ca7'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','4fdb48db-f970-45f7-9d58-bebcae3c1a26'),(9,NULL,'app','m150617_213829_update_email_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','93c4ef3e-a679-4cf6-890a-a9ffecc37dfe'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','2cb4dd20-b4ef-45f6-9acf-ad43471ce4d9'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','6062a096-213d-4954-8283-f082c10e7469'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','2387b769-d9bc-4687-941a-bd0147975239'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','bc487b2b-79c5-4715-9012-90ffa0d19c30'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','2a74cb5b-04d8-4b6e-a15e-d1d2ea562b70'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','05875a44-5d82-4e17-8a3f-147f0a275306'),(16,NULL,'app','m151209_000000_move_logo','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','fe9644d8-7ce5-4ef0-8b0d-87240fd723e2'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','3d1f79fe-6b57-444b-b56a-ccddbd98c71f'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','4c6d99a4-36a4-46fb-b567-6d6fef26d27b'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','68c442d6-2e8b-44ee-aed1-7644a3b4dedb'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','da864484-1d06-42d4-a978-efaa139140c4'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','c2d0bce4-c15c-411a-9c7c-0e7443c1b42b'),(22,NULL,'app','m160727_194637_column_cleanup','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','4328fb8e-6d25-4718-9f89-26a8c472b46c'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','0593f6ea-f033-48b0-bdcd-debc82d8235e'),(24,NULL,'app','m160807_144858_sites','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','cc368d84-cb1a-4f9a-a25b-86c8cd722bbe'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','134486d1-dc08-4255-bed0-a26092172b46'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','bc5152ae-4d57-4d38-b729-54d47637a856'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','043807a9-7045-4e1e-bbda-9a26ce9d37e9'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','b4b40fd6-a431-4bff-ad8e-b572baa6957b'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','c48fb1e1-00a6-498f-b79a-450f444d08de'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','0b8a26a1-dba7-436d-b3e5-7f07f2b6763f'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','6aa0999b-c9ea-40eb-b9f9-79f098b49187'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','4cfc06cf-736b-42bb-9dff-2696162c15eb'),(33,NULL,'app','m161007_130653_update_email_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','2e2f37f2-0d74-4cb9-93c1-a2d745365f84'),(34,NULL,'app','m161013_175052_newParentId','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','e467ab20-5cfa-426d-a240-163f448969d1'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','b41df876-ee9f-4fd9-a65a-f8babe282fee'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','57cd56ff-80eb-4749-91d0-70a5f4770d8d'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','ce5ef992-351b-40e4-aa28-631219646a5b'),(38,NULL,'app','m161029_124145_email_message_languages','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','f1a72e30-5c53-4250-94e5-ecb02e1ace41'),(39,NULL,'app','m161108_000000_new_version_format','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','c879693d-e26b-4c9d-8acb-786a4d4c060b'),(40,NULL,'app','m161109_000000_index_shuffle','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','91513003-17f3-49a3-a8a1-d82c60440ca4'),(41,NULL,'app','m161122_185500_no_craft_app','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','3a0b8a06-d113-40d3-b3a2-8fc6b73e1fd8'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','9b0f6b3f-e3c5-4a4f-aa86-c67e9e9962c5'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','63a9adb6-f0cb-40f3-8e94-3ad539f84b13'),(44,NULL,'app','m170114_161144_udates_permission','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','7d9d552d-2213-4824-b22d-4fc143460f03'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','bbc10bcb-97bd-46a3-bd3b-41d3ad281cd6'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','c7e8d10d-27c6-4d18-8127-3273eba43c4d'),(47,NULL,'app','m170206_142126_system_name','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','4cf1c82e-8055-422b-ba64-ccf5c359a829'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','cd3b70f6-b767-4ec1-9278-8d7439e4baba'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','7c40258a-cdef-4843-a6be-78a899e9da44'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','0785b0b0-f490-4cbe-a46b-590046886c4b'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','52b4c660-cc0a-4d20-8c71-6067f8397f69'),(52,NULL,'app','m170228_171113_system_messages','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','6a8a694f-9899-42cd-be2b-4b79963842d9'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','18fa0a94-5dc7-4cbf-87ec-4ef18aac1faa'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','a3249c19-b147-41df-baca-5391d325f7f7'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','f6987b2c-eee0-4d0f-879d-a3c52a250317'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','9211868f-2ddf-40bb-9d38-cac6a028de64'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','47176f2f-b120-444a-9a48-4066beadda9a'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','41f3e410-0fff-48ad-8d79-7d8f533932a2'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','4913816c-fa83-4776-a9cd-daaddc5e013d'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','34e6e5a2-5f10-4b64-95df-6ce865449930'),(61,NULL,'app','m170704_134916_sites_tables','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','c5018a81-1654-43c1-b77c-5fd1b8982f25'),(62,NULL,'app','m170706_183216_rename_sequences','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','c91e7edd-d4d3-4924-b410-19329aee1159'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','f34398c5-087c-401e-b61c-7076ea9c6e2a'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','7179434b-2f68-4d9a-add6-eb2e28e659f8'),(65,NULL,'app','m170810_201318_create_queue_table','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','2decb691-efb2-422e-9cbe-1326566eae6b'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','e9ad7331-b7ad-4fa6-bacf-59bfe93798b5'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','d3832f90-b826-40b7-b8f4-a70d777f09a4'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','1c0ae039-cd46-4107-a3f7-ac874b871cbf'),(69,NULL,'app','m171011_214115_site_groups','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','92724ee8-5cfc-448f-b7cf-d8bc077c6b34'),(70,NULL,'app','m171012_151440_primary_site','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','f64026ef-f8c4-47d0-ad87-7540fbc7c79c'),(71,NULL,'app','m171013_142500_transform_interlace','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','05839134-179c-44ae-910d-ae0ff4e94205'),(72,NULL,'app','m171016_092553_drop_position_select','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','c4e1301e-f14e-4696-ad69-147a7511f3d0'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','3d111846-6dd7-4170-9e02-763a2d0da6b0'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','db2756a2-bb9c-4050-a19c-582a7998b5ab'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','e85fe4a7-7166-478d-a752-afaf97aa361e'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','8c7096c7-a186-4dc2-b692-3dcc83e4c6f8'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','570750f4-4fb3-4ea2-a654-754b788614e2'),(78,NULL,'app','m171202_004225_update_email_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','aaa1604b-bbc9-479e-bbe8-d12b61293f27'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','eb550f96-963d-4289-bc57-4ec203ea3f3d'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','09105512-2e77-4223-aff8-1ff71dc96810'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','ae7d30e3-04a1-4e1a-aa2f-b6054341d3f2'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','ea2a0c39-3158-44cc-a26e-7321274920e3'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','2ffe4edc-509a-4bf0-89e8-5a5da91653bf'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','8a42771f-9233-4633-b1ca-661b0dd9273f'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','9a9dde11-fa36-41c7-8337-f63b996e4e66'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','b3958549-1f4f-4e91-97df-ba36db67859a'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','c503d689-2211-4c77-9d7e-c4c60a906e00'),(88,NULL,'app','m180217_172123_tiny_ints','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','843d4953-874f-44bd-8df2-981ae8fa59ac'),(89,NULL,'app','m180321_233505_small_ints','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','782acdc2-bc6c-4a81-a874-7298f1cf1bd6'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','dfaecfb3-7ae4-40d2-b2b0-6d62a25b17f5'),(91,NULL,'app','m180404_182320_edition_changes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','5eca70c5-ac37-4d92-92b5-9ff905979f9e'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','b1cb38b7-50bd-4030-9a92-2173ff7c907f'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','44ec21e0-4fd7-4a04-83fa-624f7cea15d7'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','3367e278-dee2-4120-afe2-0b1cb97cba1e'),(95,NULL,'app','m180425_203349_searchable_fields','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','cac80d96-b8f0-41e4-abf8-e72c8d65c116'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','38ba8691-ebbe-4c48-9660-c018aa039315'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','dc5ee021-88e9-4465-a081-2244493b2d39'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','09beb107-4e11-4336-ad1b-02b482223a58'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','d6004e64-f835-4902-86a2-9e0d9a81b4e6'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','bdc5ef86-bd80-48bc-b1a3-ef64f9ec5bc7'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','52f26ee3-bab1-4013-a606-a9ecb5ef8be4'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','57234842-53d8-4e55-8dcf-05357688f48d'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','97969d16-5bfa-403d-b9e5-e7e3fee9c7ac'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','a52fd2e0-6428-4dfe-aae3-03dce7118197'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','d0219ede-6d8b-4465-8e12-df859cd9e738'),(106,NULL,'app','m180904_112109_permission_changes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','abd36813-1b3a-4c3c-bcfa-d80da2c72eee'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','6d7f05fd-2009-42dd-9e42-f48101ec2300'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','9b995dae-a3dd-4325-adf4-aa5c198d7d89'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','7564473e-578d-4eef-9890-9c6a2c3d4342'),(110,NULL,'app','m181017_225222_system_config_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','f87ad5e0-ab51-45e2-8812-7be0fe096ee4'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','3bfda505-b2cb-4085-b469-226f1589c46c'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','9f5d4869-9c7d-483b-b9b3-75501a102a96'),(113,NULL,'app','m181112_203955_sequences_table','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','1ee69f15-df99-4072-88df-1a11fea0323e'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','59c672ca-1d05-41c8-9790-309c43753cf2'),(115,NULL,'app','m181128_193942_fix_project_config','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','628cff80-b0b1-4026-8100-8dc8e4f6efc4'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','f48b086d-3439-425e-9959-1198c1479306'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','83800ea2-ad68-4d1b-8fae-d459f180a63d'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','4e0b0b7f-e915-437a-a830-d1be32d11203'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','1d29bc17-4164-4f77-85be-16584b1fec61'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','aaca432d-e5f8-48d4-948f-395f416e6269'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','211b3fb8-a7e6-4d41-bdc2-eb98b6b04532'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','e1ffda46-040c-42ac-a29a-ec3083f5562c'),(123,NULL,'app','m190109_172845_fix_colspan','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','fb214a97-5cc0-48a4-b7bc-723e9e330203'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','bce22733-2731-46db-903f-266963f13a38'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','c07cbbdd-f1b9-41e4-9cd0-2762d952d08f'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','46eff215-4828-4d37-8529-d36b3d3b009d'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','a0f52ac3-7e8b-4eba-ad1e-4f059a8817f2'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','97f3cad2-c9d7-4e07-a5aa-c1c39688924c'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','0fdfb68d-9fc3-4633-9a0e-de277489a567'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','5b17fc43-9021-425b-b7a8-1e27f3be4a4d'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','afa2b4b2-8dfa-4ff0-931a-aa57457c7d74'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','e4a82479-4838-4595-8f65-233f725510c9'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','ec5b9e5f-2419-480b-8fc7-b82a7bfb61ce'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','d249e698-b65c-4b96-8d26-b98edfd3ab39'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-03-02 20:01:22','2019-03-02 20:01:22','2019-03-02 20:01:22','f623d02e-13ae-4f5e-a9bd-7f9ae65e24ae'),(136,4,'plugin','Install','2019-03-25 16:14:30','2019-03-25 16:14:30','2019-03-25 16:14:30','40da4a35-8754-4ac0-9999-8920e0c153fc'),(137,5,'plugin','m180430_204710_remove_old_plugins','2019-03-25 16:14:31','2019-03-25 16:14:31','2019-03-25 16:14:31','df160f91-5266-4ede-a09c-1a6086acc455'),(138,5,'plugin','Install','2019-03-25 16:14:31','2019-03-25 16:14:31','2019-03-25 16:14:31','e48656ed-8a88-4e32-a214-3989833f9169'),(139,6,'plugin','Install','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','4ba08d6d-68be-4fd9-b1c1-ec2056b01984'),(140,6,'plugin','m180210_000000_migrate_content_tables','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','dbd9aec6-6801-49a1-968b-afbcb674f5d9'),(141,6,'plugin','m180211_000000_type_columns','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','37c7a416-9aba-4819-8acc-6ff35065d0f3'),(142,6,'plugin','m180219_000000_sites','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','e815cb45-7154-499f-8e44-f263b9f85822'),(143,6,'plugin','m180220_000000_fix_context','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','aaf9d0ab-14ad-4535-b2f5-1752d7ae5804'),(144,6,'plugin','m190117_000000_soft_deletes','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','5598e4b5-59e2-4264-967e-c80d3ab15cd8'),(145,6,'plugin','m190117_000001_context_to_uids','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','7a92a677-43dc-4c7b-9e17-8bd727a96ddf'),(146,6,'plugin','m190120_000000_fix_supertablecontent_tables','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','dbc5ce8e-4055-4a90-b226-e1271a19f4b6'),(147,6,'plugin','m190131_000000_fix_supertable_missing_fields','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','c997dcc4-77ca-4178-88c1-be4ea694c86c'),(148,6,'plugin','m190227_100000_fix_project_config','2019-03-25 16:24:07','2019-03-25 16:24:07','2019-03-25 16:24:07','2c76da66-aad7-44f6-bca9-7c4f3729bb4c');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'child-me','1.0.4','1.0.0','unknown',NULL,'2019-03-25 15:47:32','2019-03-25 15:47:32','2019-04-07 18:39:31','5cf83a8b-fccc-4883-8808-a06c545af457'),(2,'tag-manager','1.0.1','1.0.0','unknown',NULL,'2019-03-25 15:54:21','2019-03-25 15:54:21','2019-04-07 18:39:31','103e4e9e-fb77-42fc-93d3-8434bb722ab7'),(3,'expanded-singles','1.0.7','1.0.0','unknown',NULL,'2019-03-25 15:57:12','2019-03-25 15:57:12','2019-04-07 18:39:31','18f8159f-e6a1-4257-b28f-1e24133dc79d'),(4,'cp-nav','2.0.9','2.0.0','unknown',NULL,'2019-03-25 16:14:30','2019-03-25 16:14:30','2019-04-07 18:39:31','02145109-961a-4aee-9871-ad55e97f5c30'),(5,'redactor','2.3.2','2.2.2','unknown',NULL,'2019-03-25 16:14:31','2019-03-25 16:14:31','2019-04-07 18:39:31','9da9e964-d938-4740-82ac-357803e99b5f'),(6,'super-table','2.1.16','2.0.10','unknown',NULL,'2019-03-25 16:24:07','2019-03-25 16:24:07','2019-04-07 18:39:31','74b8fa3d-ed38-4957-af0d-711c25d77330'),(7,'field-manager','2.0.5','1.0.0','unknown',NULL,'2019-03-25 16:42:34','2019-03-25 16:42:34','2019-04-07 18:39:31','b4ff277a-2522-42c8-9929-f0d9dc2f49cf'),(8,'embeddedassets','2.0.2','1.0.0','unknown',NULL,'2019-03-25 16:46:24','2019-03-25 16:46:24','2019-04-07 18:39:31','6a2d05e1-ba0a-4a0f-ac50-85982b22a3c4'),(9,'cp-css','2.1.0','2.0.0','unknown',NULL,'2019-03-26 00:17:21','2019-03-26 00:17:21','2019-04-07 18:39:31','47d9a540-ea12-497b-a181-4a9d37f197e3'),(10,'cp-field-inspect','1.0.5','1.0.0','unknown',NULL,'2019-03-26 00:25:08','2019-03-26 00:25:08','2019-04-07 18:39:31','fb242834-579a-4ad5-a3ce-810ee2740870');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `relations` VALUES (2,7,16,NULL,15,1,'2019-03-16 19:31:46','2019-03-16 19:31:46','6f9494f1-5163-45c0-84a5-a002083b2b87'),(114,38,19,NULL,8,1,'2019-04-04 04:46:43','2019-04-04 04:46:43','bfc04915-83d9-47f4-8416-dd261b481310'),(115,35,28,NULL,51,1,'2019-04-04 04:46:43','2019-04-04 04:46:43','1fcc1aae-f621-4815-aeb2-daebae439938'),(116,38,28,NULL,14,1,'2019-04-04 04:46:43','2019-04-04 04:46:43','0ca0bb08-e51d-443a-982c-b2bc95926ba5'),(117,29,41,NULL,53,1,'2019-04-04 04:54:11','2019-04-04 04:54:11','43fce13a-fb77-4d32-bce7-7023a6db375c'),(118,31,41,NULL,54,1,'2019-04-04 04:54:11','2019-04-04 04:54:11','3262e1f8-802b-4ff6-8e07-1fde110b56de'),(119,32,41,NULL,55,1,'2019-04-04 04:54:11','2019-04-04 04:54:11','e85185f2-29c1-4c24-ba0a-1550a1cc5c9e');
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('135659e2','@app/web/assets/dbbackup/dist'),('1593df28','@lib/timepicker'),('1696eb6c','@doublesecretagency/cpcss/resources'),('1aa99b73','@verbb/supertable/resources/dist'),('1ad3bf4f','@app/web/assets/sites/dist'),('1d991b6c','@app/web/assets/plugins/dist'),('1fda6f13','@lib/fileupload'),('2000c3d7','@lib/selectize'),('21058a6','@lib/prismjs'),('23de50d2','@verbb/supertable/resources/dist'),('2a6c875d','@lib/xregexp'),('2b79f88f','@app/web/assets/fields/dist'),('2c1ed6c1','@app/web/assets/dashboard/dist'),('2d82c4c4','@app/web/assets/deprecationerrors/dist'),('2f6c8d04','@lib/fabric'),('2fa944e9','@craft/web/assets/fields/dist'),('33e319b0','@app/web/assets/updates/dist'),('3a2a593a','@lib/garnishjs'),('3b6ca494','@spicyweb/embeddedassets/resources'),('40af990e','@app/web/assets/updates/dist'),('44906612','@app/web/assets/edituser/dist'),('4966d984','@lib/garnishjs'),('534c4369','@lib/selectize'),('55636620','@craft/web/assets/cp/dist'),('581f3df6','@craft/web/assets/installer/dist'),('58357831','@app/web/assets/fields/dist'),('592007e3','@lib/xregexp'),('5c18565d','@craft/web/assets/pluginstore/dist'),('5c200dba','@lib/fabric'),('5f52567f','@app/web/assets/dashboard/dist'),('66df5f96','@lib/timepicker'),('6c96efad','@lib/fileupload'),('6ed59bd2','@app/web/assets/plugins/dist'),('715cd818','@lib/prismjs'),('71a7fddf','@craft/web/assets/recententries/dist'),('7326eed','@lib/picturefill'),('73dad291','@lib/jquery-touch-events'),('747eee53','@lib/picturefill'),('77ce345a','@craft/redactor/assets/field/dist'),('7864bb80','@craft/web/assets/updater/dist'),('791fef67','@ether/tagManager/web/assets'),('7adbce02','@lib/d3'),('7bbf69c','@craft/web/assets/tablesettings/dist'),('7f8e377f','@app/web/assets/clearcaches/dist'),('7ff4947f','@app/web/assets/editentry/dist'),('81123fbe','@app/web/assets/recententries/dist'),('8442b443','@app/web/assets/tablesettings/dist'),('86300aff','@lib/jquery.payment'),('87675518','@app/web/assets/pluginstore/dist'),('8b0588be','@spicyweb/embeddedassets/resources'),('8b98526a','@bower/jquery/dist'),('8d68da1c','@app/web/assets/utilities/dist'),('8e419037','@craft/web/assets/editentry/dist'),('8e8966ab','@app/web/assets/assetindexes/dist'),('90e7c4ff','@app/web/assets/searchindexes/dist'),('938cf235','@app/web/assets/userpermissions/dist'),('9608d333','@app/web/assets/feed/dist'),('96522f','@lib/jquery-touch-events'),('98610d4d','@app/web/assets/login/dist'),('995ede6','@mmikkel/cpfieldinspect/resources'),('9974ebc','@lib/d3'),('9a17a517','@lib/velocity'),('9c5f1833','@app/web/assets/cp/dist'),('a34d6dd7','@app/web/assets/quickpost/dist'),('a408f99f','@lib/element-resize-detector'),('a7c2875c','@app/web/assets/matrixsettings/dist'),('a7f2be0c','@lib/jquery-ui'),('a8dcfccb','@app/web/assets/editcategory/dist'),('a94a9da','@vendor/craftcms/redactor/lib/redactor'),('a9aa39be','@app/web/assets/installer/dist'),('ab0c11c1','@app/web/assets/generalsettings/dist'),('ab4eb4e7','@verbb/cpnav/assetbundles/cpnav/dist'),('aee75237','@craft/web/assets/dashboard/dist'),('b12db15b','@craft/web/assets/matrixsettings/dist'),('b13ad111','@app/web/assets/craftsupport/dist'),('b3b29392','@lib'),('b9bd6af3','@app/web/assets/routes/dist'),('bfa87dd0','@app/web/assets/updateswidget/dist'),('c0fe132c','@lib'),('c27651af','@app/web/assets/craftsupport/dist'),('c6d651ce','@app/web/assets/systemmessages/dist'),('c95fa778','@ether/tagManager/web/assets'),('c998dafc','@mmikkel/cpfieldinspect/resources'),('ca008f03','@craft/web/assets/plugins/dist'),('cb814c1','@app/web/assets/editentry/dist'),('cce4fd6e','@app/web/assets/updateswidget/dist'),('d48e07e2','@app/web/assets/matrixsettings/dist'),('d4be3eb2','@lib/jquery-ui'),('d4d6810c','@app/web/assets/findreplace/dist'),('d7447921','@lib/element-resize-detector'),('d7a474fc','@craft/web/assets/feed/dist'),('d840917f','@app/web/assets/generalsettings/dist'),('dae6b900','@app/web/assets/installer/dist'),('dcb1af51','@app/web/assets/updater/dist'),('e3ab4441','@app/web/assets/searchindexes/dist'),('e544538d','@app/web/assets/feed/dist'),('e8b149b8','@craft/web/assets/craftsupport/dist'),('e95b25a9','@lib/velocity'),('eb2d8df3','@app/web/assets/login/dist'),('ef13988d','@app/web/assets/cp/dist'),('f25ebf00','@app/web/assets/recententries/dist'),('f2a3a630','@mmikkel/childme/resources'),('f42bd5a6','@app/web/assets/pluginstore/dist'),('f57c8a41','@lib/jquery.payment'),('f70e34fd','@app/web/assets/tablesettings/dist'),('f8d4d2d4','@bower/jquery/dist'),('f915eea','@craft/web/assets/utilities/dist'),('fdc5e615','@app/web/assets/assetindexes/dist'),('fe245aa2','@app/web/assets/utilities/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' egiuse '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' egiuse andrew cmu edu '),(1,'slug',0,1,''),(2,'slug',0,1,' home '),(2,'title',0,1,' home '),(4,'slug',0,1,' contact '),(4,'title',0,1,' contact '),(3,'slug',0,1,' about '),(3,'title',0,1,' about '),(6,'slug',0,1,' login '),(6,'title',0,1,' login '),(7,'filename',0,1,' massachusettsbills2363anactrelativetooralcancertherapy pdf '),(7,'extension',0,1,' pdf '),(7,'kind',0,1,' pdf '),(7,'slug',0,1,''),(7,'title',0,1,' massachusetts bill s2363an act relative to oral cancer therapy '),(7,'field',33,1,''),(7,'field',28,1,''),(8,'filename',0,1,' bill1 pdf '),(8,'extension',0,1,' pdf '),(8,'kind',0,1,' pdf '),(8,'slug',0,1,''),(8,'title',0,1,' the first bill '),(8,'field',33,1,' this bill is about important stuff '),(8,'field',28,1,' pdf aaci california '),(9,'filename',0,1,' states_localities_tobacco21 pdf '),(9,'extension',0,1,' pdf '),(9,'kind',0,1,' pdf '),(9,'slug',0,1,''),(9,'title',0,1,' states_localities_tobacco21 '),(9,'field',33,1,''),(9,'field',28,1,''),(11,'filename',0,1,' increasingtheminimumlegalsaleagefortobaccoproductsto21brief pdf '),(11,'extension',0,1,' pdf '),(11,'kind',0,1,' pdf '),(11,'slug',0,1,''),(11,'title',0,1,' increasing the minimum legal sale age for tobacco products to21brief '),(11,'field',33,1,''),(11,'field',28,1,''),(12,'filename',0,1,' increasingtheminimumlegalsaleagefortobaccoproductsto21 pdf '),(12,'extension',0,1,' pdf '),(12,'kind',0,1,' pdf '),(12,'slug',0,1,''),(12,'title',0,1,' increasing the minimum legal sale age for tobacco products to21 '),(12,'field',33,1,''),(12,'field',28,1,''),(13,'filename',0,1,' h4479anactprotectingyouthfromthehealthrisksoftobaccoandnicotineaddiction pdf '),(13,'extension',0,1,' pdf '),(13,'kind',0,1,' pdf '),(13,'slug',0,1,''),(13,'title',0,1,' h4479an act protecting youth from the health risksof tobacco and nicotine addiction '),(13,'field',33,1,''),(13,'field',28,1,''),(14,'filename',0,1,' saving womens lives accelerating action to eliminate cervical cancer globally pdf '),(14,'extension',0,1,' pdf '),(14,'kind',0,1,' pdf '),(14,'slug',0,1,''),(14,'title',0,1,' saving womens lives accelerating action to eliminate cervical cancer globally '),(14,'field',33,1,''),(14,'field',28,1,''),(19,'slug',0,1,' oral chemotherapy parity '),(19,'title',0,1,' oral chemo '),(19,'field',35,1,''),(19,'field',33,1,''),(19,'field',34,1,''),(19,'field',38,1,' bills 115hr1409ih '),(23,'slug',0,1,' test subtopic for hpv topic '),(23,'title',0,1,' test subtopic for hpv topic '),(23,'field',35,1,''),(23,'field',33,1,''),(23,'field',34,1,''),(23,'field',38,1,''),(24,'slug',0,1,' test subtopic 2 for hpv topic '),(24,'title',0,1,' test subtopic 2 for hpv topic '),(24,'field',35,1,''),(24,'field',33,1,''),(24,'field',34,1,''),(24,'field',38,1,''),(28,'slug',0,1,' hpv '),(28,'title',0,1,' hpv '),(28,'field',35,1,' img01 '),(28,'field',33,1,' human papilloma virus vaccination advocacy blah blah '),(28,'field',34,1,' pls get vaccinated '),(28,'field',38,1,' saving womens lives accelerating action to eliminate cervical cancer globally '),(29,'filename',0,1,' me at the zoo json '),(29,'extension',0,1,' json '),(29,'kind',0,1,' json '),(29,'slug',0,1,''),(29,'title',0,1,' me at the zoo '),(29,'field',33,1,''),(29,'field',28,1,''),(31,'slug',0,1,' hello '),(31,'title',0,1,' hello '),(32,'slug',0,1,' content test '),(32,'title',0,1,' content test '),(33,'slug',0,1,' a '),(33,'title',0,1,' a '),(34,'slug',0,1,' b '),(34,'title',0,1,' b '),(35,'filename',0,1,' 19 survey project instructions 1 pdf '),(35,'extension',0,1,' pdf '),(35,'kind',0,1,' pdf '),(35,'slug',0,1,''),(35,'title',0,1,' 19 survey project instructions 1 '),(35,'field',33,1,''),(35,'field',28,1,''),(36,'filename',0,1,' screen shot 2019 03 25 at 11 48 52 am png '),(36,'extension',0,1,' png '),(36,'kind',0,1,' image '),(36,'slug',0,1,''),(36,'title',0,1,' screen shot 2019 03 25 at 11 48 52 am '),(36,'field',33,1,''),(36,'field',28,1,''),(38,'slug',0,1,' c '),(38,'title',0,1,' c '),(38,'field',33,1,''),(39,'slug',0,1,' b '),(39,'title',0,1,' b '),(40,'slug',0,1,' d '),(40,'title',0,1,' d '),(41,'slug',0,1,''),(41,'field',29,1,' california '),(41,'field',30,1,''),(41,'field',31,1,' pdf '),(41,'field',32,1,' aaci '),(42,'slug',0,1,' oral subtopic '),(42,'title',0,1,' oral subtopic '),(42,'field',35,1,''),(42,'field',33,1,''),(42,'field',34,1,''),(42,'field',38,1,''),(44,'username',0,1,' testinguser2 '),(44,'firstname',0,1,''),(44,'lastname',0,1,''),(44,'fullname',0,1,''),(44,'email',0,1,' erikagiuse gmail com '),(44,'slug',0,1,''),(45,'username',0,1,' msripadam '),(45,'firstname',0,1,''),(45,'lastname',0,1,''),(45,'fullname',0,1,''),(45,'email',0,1,' sripadam cmu edu '),(45,'slug',0,1,''),(46,'slug',0,1,' pennsylvania '),(46,'title',0,1,' pennsylvania '),(47,'slug',0,1,' about '),(47,'title',0,1,' about '),(48,'slug',0,1,' topics index '),(48,'title',0,1,' topics index '),(19,'field',2,1,' oral chemotherapy parity '),(23,'field',2,1,''),(24,'field',2,1,''),(28,'field',2,1,' hpv vaccination '),(42,'field',2,1,' oral subtopic heading '),(2,'field',2,1,' cancer resource library '),(48,'field',2,1,' topics '),(47,'field',2,1,' about us '),(49,'field',2,1,' tobacco 21 '),(49,'field',35,1,''),(49,'field',33,1,''),(49,'field',34,1,''),(49,'field',38,1,''),(49,'slug',0,1,' tobacco 21 '),(49,'title',0,1,' tobacco 21 '),(50,'filename',0,1,' img12 jpg '),(50,'extension',0,1,' jpg '),(50,'kind',0,1,' image '),(50,'slug',0,1,''),(50,'title',0,1,' img12 '),(51,'filename',0,1,' img01 jpg '),(51,'extension',0,1,' jpg '),(51,'kind',0,1,' image '),(51,'slug',0,1,''),(51,'title',0,1,' img01 '),(52,'filename',0,1,' default jpg '),(52,'extension',0,1,' jpg '),(52,'kind',0,1,' image '),(52,'slug',0,1,''),(52,'title',0,1,' default '),(53,'slug',0,1,' california '),(53,'title',0,1,' california '),(54,'field',33,1,''),(54,'slug',0,1,' pdf '),(54,'title',0,1,' pdf '),(55,'slug',0,1,' aaci '),(55,'title',0,1,' aaci '),(56,'filename',0,1,' default jpg '),(56,'extension',0,1,' jpg '),(56,'kind',0,1,' image '),(56,'slug',0,1,''),(56,'title',0,1,' default ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'Home Page','home_index','single',1,1,'2019-03-12 22:00:30','2019-04-04 04:41:09',NULL,'3323900d-bc90-4c77-8638-89fe3d9baaa1'),(2,NULL,'About','about','single',1,1,'2019-03-12 22:00:42','2019-04-02 02:10:15','2019-04-02 02:10:16','384861ed-690a-4568-89e5-ba84ba7eaaa4'),(3,NULL,'Contact','contact','single',1,1,'2019-03-12 22:01:04','2019-04-02 02:10:18','2019-04-02 02:10:18','ccb21397-4937-4acd-83de-7a94303a8ead'),(4,3,'Topics Index','topics','structure',1,1,'2019-03-12 22:01:10','2019-03-20 01:31:24','2019-03-20 01:31:24','aaec7784-a57e-433f-a237-dd5ec2c00ccf'),(5,NULL,'Login','login','single',1,1,'2019-03-12 22:01:17','2019-04-02 02:10:20','2019-04-02 02:10:20','b9841718-f5d2-45c3-814f-2c4d7d9d7257'),(6,1,'Search Results','searchResults','structure',1,1,'2019-03-14 00:21:52','2019-03-16 22:41:17','2019-03-16 22:41:17','c81b2166-00fe-48cf-b17c-2b6f583cfd66'),(7,2,'Topic - Show Page','all_topics','structure',1,1,'2019-03-16 19:08:07','2019-04-04 04:39:28',NULL,'c469a882-e929-4b33-9e7b-bea1c720755e'),(8,NULL,'Subtopics Index','subtopicsIndex','single',1,1,'2019-03-16 20:08:46','2019-03-20 01:16:47','2019-03-20 01:16:47','b7fab0df-2050-44fa-aec1-c2614151c5e6'),(9,6,'Topics/Subtopics Resources','topicsSubtopicsResources','structure',1,1,'2019-03-26 18:31:07','2019-03-26 18:32:24','2019-03-26 18:32:24','fbf5eaa9-5a6b-4c3c-b4b3-87eb57144856'),(10,NULL,'About Page','about_index','single',1,1,'2019-04-02 02:11:19','2019-04-04 04:40:57',NULL,'6bf6ecfb-cd83-47f9-8c99-d75b4e1b9b89'),(11,NULL,'Topics - Index Page','topics_index','single',1,1,'2019-04-02 02:23:21','2019-04-04 04:37:58',NULL,'467a7187-2226-4c46-bcc4-3b390493f66a');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'__home__','home',1,'2019-03-12 22:00:30','2019-04-04 04:41:09','88c65ed4-e2ee-4f5b-b014-67f128f09b9d'),(2,2,1,1,'about','',1,'2019-03-12 22:00:42','2019-04-02 02:10:16','f330d0c6-3a99-497f-a6e6-9fdcd4f74246'),(3,3,1,1,'contact','',1,'2019-03-12 22:01:04','2019-04-02 02:10:18','4130e9b0-16db-4d2d-b7b1-c540a9761b3f'),(4,4,1,1,'topics','',1,'2019-03-12 22:01:10','2019-03-20 01:31:24','e19192c9-146e-460d-850e-e0078d171369'),(5,5,1,1,'login','',1,'2019-03-12 22:01:17','2019-04-02 02:10:20','06a26d0e-b953-4dc7-a146-e044a45c12fe'),(6,6,1,1,'search-results/{slug}','',1,'2019-03-14 00:21:52','2019-03-16 22:41:17','07805664-b71a-4f1a-8a30-f34dbfb115fc'),(7,7,1,1,'{parent.uri}/{slug}','topic_show',1,'2019-03-16 19:08:07','2019-04-04 04:39:28','3bd41a70-eb99-446b-9302-ec0772a087fc'),(8,8,1,1,'subtopics','subtopics/_index',1,'2019-03-16 20:08:46','2019-03-20 01:16:47','b1e73d2b-84e6-4c5f-833c-697a415c4748'),(9,9,1,1,'topics-subtopics-resources/{slug}','',1,'2019-03-26 18:31:08','2019-03-26 18:32:24','8af52363-15dd-4eca-8db4-155204d3f3ee'),(10,10,1,1,'/about','about',1,'2019-04-02 02:11:19','2019-04-04 04:40:57','44c18841-c0c7-4d94-a5eb-ada1fd8afa30'),(11,11,1,1,'/topics','topics_index',1,'2019-04-02 02:23:21','2019-04-04 04:37:58','a55db8b0-ab7a-4161-9360-274747891b1c');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Craft3manual','2019-03-02 20:01:21','2019-03-02 20:01:21',NULL,'36f6937e-673b-4f31-845c-d37b7f19de90');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'Craft3manual','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-03-02 20:01:21','2019-03-02 20:01:21',NULL,'06419039-5941-41b4-a10b-a0003a4a0a8a');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `stc_resourcetagsfield`
--

LOCK TABLES `stc_resourcetagsfield` WRITE;
/*!40000 ALTER TABLE `stc_resourcetagsfield` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `stc_resourcetagsfield` VALUES (1,41,1,'2019-03-28 16:19:07','2019-04-04 04:54:11','723c0432-dbf9-4970-958e-4e76a98c0ea1');
/*!40000 ALTER TABLE `stc_resourcetagsfield` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structureelements` VALUES (1,2,NULL,1,1,14,0,'2019-03-16 19:31:41','2019-04-02 18:45:55','2bbc7a5e-50f4-43ce-a1a0-89fa765a1c5c'),(4,2,19,1,2,5,1,'2019-03-16 20:11:25','2019-03-28 16:19:39','c138efd0-ad37-4a3e-87e6-bf134e7dac86'),(5,3,NULL,5,1,2,0,'2019-03-19 12:54:25','2019-03-20 01:31:24','b0334c67-f036-4849-a77f-0e556fb29808'),(7,5,NULL,7,1,2,0,'2019-03-20 01:14:43','2019-03-20 01:15:55','c029347f-8548-4a90-abd5-6dc70a987dcd'),(11,2,23,1,9,10,2,'2019-03-20 14:54:28','2019-03-28 16:19:39','1588ce3d-bb57-44b2-8f4a-80dcfb6219ff'),(12,2,24,1,7,8,2,'2019-03-20 14:54:49','2019-03-28 16:19:39','a33b5dcb-6a7f-48df-a5c1-87876d75cc1b'),(13,2,28,1,6,11,1,'2019-03-23 17:33:14','2019-03-28 16:19:39','5668a79e-3393-49cc-943c-323b7c3852a8'),(15,2,42,1,3,4,2,'2019-03-28 16:19:39','2019-03-28 16:19:39','536c2e44-7754-473f-beca-684357dc6a17'),(16,2,49,1,12,13,1,'2019-04-02 18:45:55','2019-04-02 18:45:55','c290c71d-3963-4718-8773-476cc5bc2405');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structures` VALUES (1,NULL,'2019-03-14 00:21:52','2019-03-16 22:41:17','2019-03-16 22:41:17','f785f735-73aa-48bf-b5fb-7f87d5653a80'),(2,NULL,'2019-03-16 19:08:07','2019-04-04 04:39:28',NULL,'1cdb4495-063e-48df-b0e9-31f4b275d062'),(3,NULL,'2019-03-19 12:54:25','2019-03-20 01:31:24','2019-03-20 01:31:24','10b8ad76-068c-4497-9c73-a136ae5d5a95'),(4,NULL,'2019-03-20 01:09:35','2019-03-20 01:09:35','2019-03-20 01:10:58','8f87ef6a-148f-40db-8296-ad3990dab754'),(5,NULL,'2019-03-20 01:14:07','2019-03-20 01:14:30',NULL,'f86a74ca-7e91-4e78-8af6-452451af6d4a'),(6,NULL,'2019-03-26 18:31:07','2019-03-26 18:32:24','2019-03-26 18:32:24','a2f49eec-1baf-44d8-9dcc-9b3c81857a9b');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `supertableblocks`
--

LOCK TABLES `supertableblocks` WRITE;
/*!40000 ALTER TABLE `supertableblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `supertableblocks` VALUES (41,8,NULL,28,2,1,NULL,'2019-03-28 16:19:07','2019-04-04 04:54:11','19a78ac6-1da2-4585-9970-6cf8a2ad526f');
/*!40000 ALTER TABLE `supertableblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `supertableblocktypes`
--

LOCK TABLES `supertableblocktypes` WRITE;
/*!40000 ALTER TABLE `supertableblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `supertableblocktypes` VALUES (2,28,14,'2019-03-26 00:43:58','2019-04-04 04:46:14','b87e3609-07d3-4f8d-b014-02d43c1b7e6b');
/*!40000 ALTER TABLE `supertableblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `taggroups` VALUES (1,'File Type','fileType',1,'2019-03-14 04:43:28','2019-03-26 12:13:23',NULL,'d9eafeb5-1a3b-41cd-9ca3-6f880f1a131d'),(2,'Subtopic Name','subtopicName',2,'2019-03-14 04:43:59','2019-03-14 04:46:56','2019-03-16 19:00:12','9d115e3f-45ef-4149-9ac7-b52cc98f38b4'),(3,'Topic Name','topicName',3,'2019-03-14 04:44:04','2019-03-14 04:47:07','2019-03-16 19:00:16','58a569e5-2feb-4694-96f3-828da0742b77'),(4,'Title','documentTitle',NULL,'2019-03-16 19:01:00','2019-04-01 02:16:53',NULL,'f2cd8507-090e-414c-b6ea-fb24c7120ee9'),(5,'Resource Date','resourceDate',NULL,'2019-03-16 19:01:44','2019-03-16 19:01:44','2019-04-01 02:16:20','230a2487-2ccf-4065-88c9-55e380e3ea59'),(6,'Institution','institution',NULL,'2019-03-16 19:02:01','2019-03-16 19:02:01',NULL,'3cf0a51d-6681-4ef9-a9d2-827f9e0ed36a'),(7,'State','documentState',NULL,'2019-03-16 19:02:17','2019-04-01 02:17:09',NULL,'5fd43216-4949-46d6-a2c5-07b661977ab1'),(8,'Location: Country','locationCountry',NULL,'2019-03-16 19:02:21','2019-03-16 19:02:21','2019-04-01 02:16:42','46218243-f168-4c02-b462-7a520b7b5890'),(9,'Content','documentContent',NULL,'2019-03-16 19:02:50','2019-04-01 02:17:23',NULL,'f870fcf5-c00e-4116-8119-beb68daab851'),(10,'Required Tags','requiredtags',12,'2019-03-25 16:40:14','2019-03-26 00:35:31','2019-03-26 00:37:43','8e945bd5-8fc6-4dd5-9391-4e0732a0dbc1'),(11,'OptionalTags','optionaltags',13,'2019-03-25 16:40:20','2019-03-26 00:35:40','2019-03-26 00:37:46','27ac1b84-11b1-417c-b637-5ca1c0432450');
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tags` VALUES (15,9,0,'2019-03-16 19:31:37','2019-03-16 19:31:37','24ddb0a1-8f9b-48fe-b6fb-5e5e568284d5'),(25,9,0,'2019-03-23 16:53:34','2019-03-23 16:53:34','1fea34e5-577b-4acb-83c6-398e9f48a158'),(26,9,0,'2019-03-23 16:53:38','2019-03-23 16:53:38','79a0ca74-a49b-4d35-93eb-0b8a5b280104'),(31,7,0,'2019-03-26 00:38:51','2019-03-26 00:38:51','2e1c5645-5b5f-47d1-a2f1-3f732abbd05f'),(32,9,0,'2019-03-26 00:39:41','2019-03-27 19:25:51','f611a877-d989-43d3-a295-350ceb06bf84'),(33,7,0,'2019-03-26 00:45:53','2019-03-26 00:45:53','cfe7e852-c780-4211-bd61-964f3f788ca1'),(34,7,0,'2019-03-26 00:45:56','2019-03-26 00:45:56','ba870ff9-a2cb-4e0f-9727-519dc4622260'),(38,1,NULL,'2019-03-28 16:19:01','2019-03-28 16:19:01','a201b977-858c-4706-b078-524bb6593c9a'),(39,9,0,'2019-03-28 16:19:03','2019-03-28 16:19:03','f122f71f-f4c1-40fb-82f4-19d005a9b5bc'),(40,6,0,'2019-03-28 16:19:06','2019-03-28 16:19:06','14b94b72-e3d7-4d7f-8bd2-160db635e2b9'),(46,7,NULL,'2019-04-01 02:18:28','2019-04-01 02:18:28','aa563587-5e49-4b06-ad3c-143b4c8ba9ba'),(53,7,NULL,'2019-04-04 04:53:56','2019-04-04 04:53:56','5255549d-8588-449e-8c92-a550651caa18'),(54,1,NULL,'2019-04-04 04:54:04','2019-04-04 04:54:04','b6c74bdb-7bcf-454c-bff9-ed6a563d7de9'),(55,6,NULL,'2019-04-04 04:54:10','2019-04-04 04:54:10','a5e053e2-1cef-4490-ab01-05dc88668ffa');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tokens` VALUES (7,'LeysfxT6IvSTBkCS6wllBLbPA0CL7a9E','[\"live-preview/preview\",{\"previewAction\":\"entries/preview-entry\",\"userId\":\"1\"}]',NULL,NULL,'2019-04-02 02:09:17','2019-04-01 02:09:17','2019-04-01 02:09:17','23609667-77d0-4b20-a365-96508e11e061'),(8,'ugaaNn8juXDVP7euI1_fePWFVnA-ACn3','[\"live-preview/preview\",{\"previewAction\":\"entries/preview-entry\",\"userId\":\"1\"}]',NULL,NULL,'2019-04-02 02:10:45','2019-04-01 02:10:45','2019-04-01 02:10:45','196762bb-98c3-451e-97fd-24bfdbd88742');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\",\"weekStartDay\":\"1\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}'),(43,'{\"language\":null,\"weekStartDay\":null,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}'),(44,'{\"language\":null,\"weekStartDay\":null}'),(45,'{\"language\":\"en-US\",\"weekStartDay\":\"1\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'egiuse',NULL,'','','egiuse@andrew.cmu.edu','$2y$13$RU0Fw9HNgnBALUJKgeqhyeIVa64d3BSKiR0Cw/8eqx5z3ufRR3NEm',1,0,0,0,'2019-04-02 16:13:07',NULL,NULL,NULL,'2019-03-30 19:47:54',NULL,1,NULL,NULL,NULL,0,'2019-03-30 19:18:16','2019-03-02 20:01:21','2019-04-02 16:13:07','5726da05-ed6c-4e0a-b9c4-e8bcb148ea1b'),(43,'testingUser',NULL,'','','sripadam@cmu.edu','$2y$13$rVC1OwlkuYbHvMIfLOO0gebZ7UxDJlCgkePL4b2ORC.UCvW2AHNbe',1,0,0,0,'2019-03-29 20:18:27',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-03-29 20:26:09','2019-03-29 20:12:17','2019-03-29 20:26:09','75459afb-954c-4513-b7be-4c0c43657b59'),(44,'testinguser2',NULL,'','','erikagiuse@gmail.com',NULL,0,0,0,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'$2y$13$1xFqSdWbJBmelHNFJSdub.51L2jMN5rOW8apUb/rjJTOZJMbNvwny','2019-03-29 20:13:48','erikagiuse@gmail.com',0,NULL,'2019-03-29 20:13:47','2019-03-29 20:13:48','d75c8084-b264-4902-aa25-bab289a08a8f'),(45,'msripadam',NULL,'','','sripadam@cmu.edu','$2y$13$kLDEwCsXCOPBR3LHqyT9ZuZlhLKYjvQhCvNVQr/dPWRHqw0gM8Hm6',1,0,0,0,'2019-04-07 18:39:28',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-03-30 19:49:32','2019-03-30 19:46:57','2019-04-07 18:39:28','ec568fc4-3a06-4a9f-8fac-8a1c6882abcc');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Topic Icons','','2019-03-14 00:33:47','2019-04-02 20:48:05','c6a8fd96-0149-49ab-80d2-496663e80dec'),(2,NULL,2,'Subtopic Icons','','2019-03-14 00:34:35','2019-04-07 20:22:24','11768569-5676-4b28-bb57-58ada962f702'),(3,NULL,NULL,'Temporary source',NULL,'2019-03-14 00:36:53','2019-03-14 00:36:53','eddd3405-ae81-4893-95c0-f461ce5ef622'),(4,3,NULL,'user_1','user_1/','2019-03-14 00:36:53','2019-03-14 00:36:53','ad88d87e-3879-4f17-b8c2-9ac432414fc5'),(5,NULL,3,'Oral Chemotherapy Parity','','2019-03-14 00:41:16','2019-03-20 01:27:01','36b8bdac-0901-40c4-a073-0dd10118d7aa'),(6,NULL,4,'Tobacco','','2019-03-14 00:41:45','2019-03-14 00:41:45','443e24ad-2b2f-4eb1-b5ba-db4bbcbaba8a'),(7,NULL,5,'HPV','','2019-03-14 00:42:15','2019-03-14 00:42:15','fea63d1d-b684-4bf1-8fa8-a974c770ad7c'),(8,NULL,6,'State Funding for Research','','2019-03-14 00:42:53','2019-03-14 00:42:53','145d0d3e-a978-4c73-a99c-f806813697e3'),(9,NULL,7,'Resources','','2019-03-20 01:35:23','2019-03-26 18:41:28','fc77a882-4cd8-46d3-a071-0cf98b829216'),(10,9,7,'Oral Chemotherapy Parity','Oral Chemotherapy Parity/','2019-03-20 01:35:52','2019-03-20 01:35:52','5dece2b3-69bf-44e2-bee4-b18e8b06aa09'),(11,9,7,'Tobacco','Tobacco/','2019-03-20 01:37:16','2019-03-20 01:40:13','7e56df0e-2488-430b-9363-ad074cb21318'),(12,9,7,'HPV','HPV/','2019-03-20 01:40:32','2019-03-20 01:41:13','139a962c-b78d-43dc-aafe-fe9ab1eca05f'),(13,9,7,'State Funding for Research','State Funding for Research/','2019-03-20 01:41:28','2019-03-20 01:41:28','07b8d74c-fe5f-4971-8705-c18c5a57db38'),(14,3,NULL,'user_45','user_45/','2019-04-07 20:10:35','2019-04-07 20:10:35','c388654a-4674-45c7-97a6-8797dbc78bfc');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,NULL,'Topic Icons','topicIcons','craft\\volumes\\Local',1,'/assets/img/topic-icons','{\"path\":\"@webroot/assets/img/topic-icons\"}',1,'2019-03-14 00:33:47','2019-04-02 20:48:05',NULL,'af5d9f4c-8370-4936-b18f-2656c9900a8d'),(2,NULL,'Subtopic Icons','subtopicIcons','craft\\volumes\\Local',0,NULL,'{\"path\":\"@webroot/assets/icons/subtopic-icons\"}',2,'2019-03-14 00:34:35','2019-04-07 20:22:24',NULL,'14a5170c-9eed-42d3-a7e7-103749b44e85'),(3,NULL,'Oral Chemotherapy Parity','oralChemotherapyParity','craft\\volumes\\Local',0,NULL,'{\"path\":\"@webroot/assets/resources/oral_chemo\"}',3,'2019-03-14 00:41:16','2019-03-20 01:27:01','2019-03-20 01:37:49','0d76dc4b-6a7e-45a2-8bd8-8f0d2bc6dc6d'),(4,NULL,'Tobacco','tobacco','craft\\volumes\\Local',0,NULL,'{\"path\":\"@webroot/assets/resources/tobacco\"}',4,'2019-03-14 00:41:45','2019-03-14 00:41:45','2019-03-20 01:37:46','8096df03-6d17-4cb1-9757-972f0475de20'),(5,NULL,'HPV','hpv','craft\\volumes\\Local',0,NULL,'{\"path\":\"@webroot/assets/resources/HPV\"}',5,'2019-03-14 00:42:15','2019-03-14 00:42:15','2019-03-20 01:40:55','71d512dc-5b37-46f8-976b-e9df1ee45c41'),(6,NULL,'State Funding for Research','stateFundingForResearch','craft\\volumes\\Local',0,NULL,'{\"path\":\"@webroot/assets/resources/state_fund\"}',6,'2019-03-14 00:42:53','2019-03-14 00:42:53','2019-03-20 01:41:49','f4c261ba-441a-434e-9b4c-b3171f46bc7a'),(7,15,'Resources','resources','craft\\volumes\\Local',0,NULL,'{\"path\":\"@webroot/assets/resources\"}',7,'2019-03-20 01:35:23','2019-03-26 18:41:28',NULL,'c9fb2884-b316-47b8-8ee1-8c13739b99cb');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-03-02 20:01:23','2019-03-02 20:01:23','5ec9be19-04aa-41a3-8fd9-c5ab32929e32'),(7,43,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-03-29 20:18:27','2019-03-29 20:18:27','af2ab1d3-2ca3-4473-b7cd-8558a6efdee5'),(8,43,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-03-29 20:18:27','2019-03-29 20:18:27','6c027412-9452-4fd8-8e94-f49627296bcf'),(9,43,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-03-29 20:18:27','2019-03-29 20:18:27','f92721e0-6bae-47d6-b88c-f67fdd4131c1'),(10,43,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-03-29 20:18:27','2019-03-29 20:18:27','d32bb6b1-6232-4d71-af73-517c6a51d984'),(11,45,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-03-30 19:47:17','2019-03-30 19:47:17','5036458f-c884-4468-a6bc-d3f200b65f7a'),(12,45,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-03-30 19:47:17','2019-03-30 19:47:17','02589086-6256-494f-a26a-4035dba8f304'),(13,45,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-03-30 19:47:17','2019-03-30 19:47:17','d20c9fec-daca-42b5-8274-8180959f2112'),(14,45,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-03-30 19:47:17','2019-03-30 19:47:17','5df08a3f-842f-4f98-b8be-fe142534b204');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'aaci_2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-07 18:02:17
