-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: insurance_mlaas
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS insurance_mlaas;

USE insurance_mlaas;

--
-- Table structure for table `billing_details`
--

DROP TABLE IF EXISTS `billing_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_details` (
  `detail_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `billing_id` int DEFAULT NULL,
  `service_type` varchar(50) NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`detail_id`),
  UNIQUE KEY `detail_id` (`detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_details`
--

LOCK TABLES `billing_details` WRITE;
/*!40000 ALTER TABLE `billing_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_records`
--

DROP TABLE IF EXISTS `billing_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_records` (
  `billing_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` varchar(100) NOT NULL,
  `billing_period_start` date NOT NULL,
  `billing_period_end` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `invoice_number` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`billing_id`),
  UNIQUE KEY `billing_id` (`billing_id`),
  KEY `idx_billing_organization` (`organization_id`),
  KEY `idx_billing_status` (`status`),
  CONSTRAINT `billing_records_chk_1` CHECK ((`status` in (_utf8mb4'PENDING',_utf8mb4'INVOICED',_utf8mb4'PAID',_utf8mb4'CANCELLED')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_records`
--

LOCK TABLES `billing_records` WRITE;
/*!40000 ALTER TABLE `billing_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `claim_predictions`
--

DROP TABLE IF EXISTS `claim_predictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `claim_predictions` (
  `prediction_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `claim_id` int DEFAULT NULL,
  `model_id` int DEFAULT NULL,
  `predicted_value` decimal(10,2) NOT NULL,
  `confidence_score` decimal(5,2) DEFAULT NULL,
  `prediction_features` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`prediction_id`),
  UNIQUE KEY `prediction_id` (`prediction_id`),
  KEY `idx_predictions_claim_id` (`claim_id`),
  KEY `idx_predictions_model_id` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claim_predictions`
--

LOCK TABLES `claim_predictions` WRITE;
/*!40000 ALTER TABLE `claim_predictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `claim_predictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_processing_records`
--

DROP TABLE IF EXISTS `data_processing_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_processing_records` (
  `record_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_subject_type` varchar(50) NOT NULL,
  `processing_purpose` text NOT NULL,
  `legal_basis` varchar(100) NOT NULL,
  `data_categories` text NOT NULL,
  `retention_period` varchar(100) DEFAULT NULL,
  `security_measures` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `record_id` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_processing_records`
--

LOCK TABLES `data_processing_records` WRITE;
/*!40000 ALTER TABLE `data_processing_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_processing_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurance_claims`
--

DROP TABLE IF EXISTS `insurance_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance_claims` (
  `claim_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `external_claim_id` varchar(50) DEFAULT NULL,
  `submitted_by` int DEFAULT NULL,
  `injury_type` varchar(100) NOT NULL,
  `prognosis` int DEFAULT NULL,
  `travel_costs` decimal(10,2) DEFAULT NULL,
  `loss_of_earnings` decimal(10,2) DEFAULT NULL,
  `additional_expenses` json DEFAULT NULL,
  `actual_settlement` decimal(10,2) DEFAULT NULL,
  `predicted_settlement` decimal(10,2) DEFAULT NULL,
  `prediction_confidence` decimal(5,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`claim_id`),
  UNIQUE KEY `claim_id` (`claim_id`),
  UNIQUE KEY `external_claim_id` (`external_claim_id`),
  KEY `idx_claims_submitted_by` (`submitted_by`),
  KEY `idx_claims_status` (`status`),
  CONSTRAINT `insurance_claims_chk_1` CHECK ((`status` in (_utf8mb4'PENDING',_utf8mb4'PROCESSED',_utf8mb4'SETTLED',_utf8mb4'REJECTED')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance_claims`
--

LOCK TABLES `insurance_claims` WRITE;
/*!40000 ALTER TABLE `insurance_claims` DISABLE KEYS */;
/*!40000 ALTER TABLE `insurance_claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml_models`
--

DROP TABLE IF EXISTS `ml_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ml_models` (
  `model_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `version` varchar(20) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `description` text,
  `performance_metrics` json NOT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `model_id` (`model_id`),
  UNIQUE KEY `name` (`name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml_models`
--

LOCK TABLES `ml_models` WRITE;
/*!40000 ALTER TABLE `ml_models` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_performance_metrics`
--

DROP TABLE IF EXISTS `model_performance_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_performance_metrics` (
  `metric_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `model_id` int DEFAULT NULL,
  `evaluation_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `metric_name` varchar(50) NOT NULL,
  `metric_value` decimal(10,5) NOT NULL,
  `dataset_info` json DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`metric_id`),
  UNIQUE KEY `metric_id` (`metric_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_performance_metrics`
--

LOCK TABLES `model_performance_metrics` WRITE;
/*!40000 ALTER TABLE `model_performance_metrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_performance_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prediction_feedback`
--

DROP TABLE IF EXISTS `prediction_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prediction_feedback` (
  `feedback_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `prediction_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comments` text,
  `override_value` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`feedback_id`),
  UNIQUE KEY `feedback_id` (`feedback_id`),
  CONSTRAINT `prediction_feedback_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prediction_feedback`
--

LOCK TABLES `prediction_feedback` WRITE;
/*!40000 ALTER TABLE `prediction_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `prediction_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_logs`
--

DROP TABLE IF EXISTS `system_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_logs` (
  `log_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `action_type` varchar(50) NOT NULL,
  `resource_type` varchar(50) DEFAULT NULL,
  `resource_id` int DEFAULT NULL,
  `details` json DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `log_id` (`log_id`),
  KEY `idx_logs_user_id` (`user_id`),
  KEY `idx_logs_action_type` (`action_type`),
  KEY `idx_logs_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_logs`
--

LOCK TABLES `system_logs` WRITE;
/*!40000 ALTER TABLE `system_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `user_type` varchar(20) NOT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `date_joined` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `users_chk_1` CHECK ((`user_type` in (_utf8mb4'END_USER',_utf8mb4'AI_ENGINEER',_utf8mb4'ADMIN',_utf8mb4'FINANCE')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS accounts_customuser (
    id INT AUTO_INCREMENT PRIMARY KEY,
    password VARCHAR(128) NOT NULL,
    last_login TIMESTAMP NULL,
    is_superuser BOOLEAN NOT NULL DEFAULT FALSE,
    username VARCHAR(150) NOT NULL UNIQUE,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    email VARCHAR(254) NOT NULL UNIQUE,
    is_staff BOOLEAN NOT NULL DEFAULT FALSE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    organization VARCHAR(100),
    user_type VARCHAR(20) NOT NULL
);

INSERT INTO accounts_customuser (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, organization, user_type) 
VALUES 
(1, 'hashed_password', NULL, 0, 'enduser1', 'End', 'User', 'enduser1@example.com', 0, 1, NOW(), 'ExampleOrg', 'END_USER'),
(2, 'hashed_password', NULL, 0, 'aiengineer1', 'AI', 'Engineer', 'aiengineer1@example.com', 0, 1, NOW(), 'ExampleOrg', 'AI_ENGINEER'),
(3, 'hashed_password', NULL, 1, 'admin1', 'Admin', 'User', 'admin1@example.com', 1, 1, NOW(), 'ExampleOrg', 'ADMIN'),
(4, 'hashed_password', NULL, 0, 'finance1', 'Finance', 'User', 'finance1@example.com', 0, 1, NOW(), 'ExampleOrg', 'FINANCE');

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-27  8:45:00
