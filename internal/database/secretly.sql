CREATE TABLE "tenants" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "name" varchar(255),
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "users" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "name" varchar(255),
  "email" varchar(255) UNIQUE,
  "emailVerified" boolean,
  "tenantId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "oauth_accounts" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "userId" varchar(64) NOT NULL,
  "provider" varchar(64) NOT NULL,
  "providerAccountId" varchar(255) NOT NULL,
  "refreshToken" varchar(255),
  "accessToken" varchar(255),
  "expiresAt" timestamp,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "magic_links" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "userId" varchar(64) NOT NULL,
  "token" varchar(255) UNIQUE NOT NULL,
  "expiresAt" timestamp,
  "createdAt" timestamp
);

CREATE TABLE "roles" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "name" varchar(255),
  "tenantId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "permissions" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "description" text,
  "actionId" varchar(64) NOT NULL,
  "resourceId" varchar(64),
  "tenantId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "actions" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "name" varchar(255),
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "resources" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "name" varchar(255),
  "type" varchar(255),
  "tenantId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "access_control" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "userId" varchar(64) NOT NULL,
  "permissionId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "projects" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "name" varchar(255),
  "tenantId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "teams" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "name" varchar(255),
  "tenantId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "team_members" (
  "teamId" varchar(64) NOT NULL,
  "userId" varchar(64) NOT NULL,
  "role" varchar(64),
  "primary" key(teamId,userId)
);

CREATE TABLE "sessions" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "userId" varchar(64) NOT NULL,
  "token" varchar(255) UNIQUE,
  "expiresAt" timestamp,
  "createdAt" timestamp
);

CREATE TABLE "secrets" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "key" varchar(255),
  "value" varchar(255),
  "tenantId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "environments" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "name" varchar(255),
  "tenantId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

CREATE TABLE "user_credentials" (
  "userId" varchar(64) PRIMARY KEY,
  "passwordHash" varchar(255) NOT NULL,
  "lastLogin" timestamp
);

CREATE TABLE "user_roles" (
  "userId" varchar(64) NOT NULL,
  "roleId" varchar(64) NOT NULL,
  "primary" key(userId,roleId)
);

CREATE TABLE "role_permissions" (
  "roleId" varchar(64) NOT NULL,
  "permissionId" varchar(64) NOT NULL,
  "primary" key(roleId,permissionId)
);

CREATE TABLE "audit_logs" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "userId" varchar(64),
  "action" varchar(255),
  "resourceId" varchar(64),
  "details" text,
  "timestamp" timestamp,
  "tenantId" varchar(64) NOT NULL
);

CREATE TABLE "resource_hierarchy" (
  "parentId" varchar(64),
  "childId" varchar(64),
  "primary" key(parentId,childId)
);

CREATE TABLE "api_keys" (
  "id" varchar(64) UNIQUE PRIMARY KEY,
  "userId" varchar(64),
  "key" varchar(255) UNIQUE,
  "name" varchar(255),
  "expiresAt" timestamp,
  "tenantId" varchar(64) NOT NULL,
  "createdAt" timestamp,
  "updatedAt" timestamp
);

ALTER TABLE "users" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");

ALTER TABLE "oauth_accounts" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "magic_links" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "roles" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");

ALTER TABLE "permissions" ADD FOREIGN KEY ("actionId") REFERENCES "actions" ("id");

ALTER TABLE "permissions" ADD FOREIGN KEY ("resourceId") REFERENCES "resources" ("id");

ALTER TABLE "permissions" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");

ALTER TABLE "resources" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");

ALTER TABLE "access_control" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "access_control" ADD FOREIGN KEY ("permissionId") REFERENCES "permissions" ("id");

ALTER TABLE "projects" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");

ALTER TABLE "teams" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");

ALTER TABLE "team_members" ADD FOREIGN KEY ("teamId") REFERENCES "teams" ("id");

ALTER TABLE "team_members" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "sessions" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "secrets" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");

ALTER TABLE "environments" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");

ALTER TABLE "user_credentials" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "user_roles" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "user_roles" ADD FOREIGN KEY ("roleId") REFERENCES "roles" ("id");

ALTER TABLE "role_permissions" ADD FOREIGN KEY ("roleId") REFERENCES "roles" ("id");

ALTER TABLE "role_permissions" ADD FOREIGN KEY ("permissionId") REFERENCES "permissions" ("id");

ALTER TABLE "audit_logs" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "audit_logs" ADD FOREIGN KEY ("resourceId") REFERENCES "resources" ("id");

ALTER TABLE "audit_logs" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");

ALTER TABLE "resource_hierarchy" ADD FOREIGN KEY ("parentId") REFERENCES "resources" ("id");

ALTER TABLE "resource_hierarchy" ADD FOREIGN KEY ("childId") REFERENCES "resources" ("id");

ALTER TABLE "api_keys" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "api_keys" ADD FOREIGN KEY ("tenantId") REFERENCES "tenants" ("id");
