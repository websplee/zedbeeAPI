IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblCategories] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [CategoryName] nvarchar(max) NULL,
        CONSTRAINT [PK_tblCategories] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblQuotaGroup] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        CONSTRAINT [PK_tblQuotaGroup] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblReissueTypes] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [Description] nvarchar(max) NULL,
        CONSTRAINT [PK_tblReissueTypes] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblUnitOfMeasures] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [UOMDescription] nvarchar(max) NULL,
        CONSTRAINT [PK_tblUnitOfMeasures] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblDepartments] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [QuotaGroupId] bigint NOT NULL,
        CONSTRAINT [PK_tblDepartments] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblDepartments_tblQuotaGroup_QuotaGroupId] FOREIGN KEY ([QuotaGroupId]) REFERENCES [tblQuotaGroup] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblStockItems] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [CategoryId] bigint NOT NULL,
        [StockNumber] nvarchar(max) NULL,
        [StockName] nvarchar(max) NULL,
        [UnitOfMeasureId] int NOT NULL,
        [Quantity] int NOT NULL,
        [ReorderQuantity] int NOT NULL,
        [Notes] nvarchar(max) NULL,
        [UnitOfMeasureId1] bigint NULL,
        CONSTRAINT [PK_tblStockItems] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblStockItems_tblCategories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [tblCategories] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblStockItems_tblUnitOfMeasures_UnitOfMeasureId1] FOREIGN KEY ([UnitOfMeasureId1]) REFERENCES [tblUnitOfMeasures] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblEmployees] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [DepartmentId] bigint NOT NULL,
        [QuotaGroupId] bigint NOT NULL,
        [Fullname] nvarchar(max) NULL,
        [EmployeeNumber] nvarchar(max) NULL,
        [MobileNumber] int NOT NULL,
        [Extension] int NOT NULL,
        [Email] nvarchar(max) NULL,
        CONSTRAINT [PK_tblEmployees] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblEmployees_tblDepartments_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [tblDepartments] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblEmployees_tblQuotaGroup_QuotaGroupId] FOREIGN KEY ([QuotaGroupId]) REFERENCES [tblQuotaGroup] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblDepartmentStockIssueHistory] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [DepartmentId] bigint NOT NULL,
        [StockItemId] bigint NOT NULL,
        [Quantity] decimal(18, 2) NOT NULL,
        [DateReceived] datetime2 NOT NULL,
        CONSTRAINT [PK_tblDepartmentStockIssueHistory] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblDepartmentStockIssueHistory_tblDepartments_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [tblDepartments] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblDepartmentStockIssueHistory_tblStockItems_StockItemId] FOREIGN KEY ([StockItemId]) REFERENCES [tblStockItems] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblQuotaGroupQuota] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Threshold] decimal(18, 2) NOT NULL,
        [WarningLevel] decimal(18, 2) NOT NULL,
        [GraceAmount] decimal(18, 2) NOT NULL,
        [Id] bigint NOT NULL IDENTITY,
        [QuotaGroupId] bigint NOT NULL,
        [StockItemId] bigint NOT NULL,
        [ReissueTypeId] bigint NOT NULL,
        CONSTRAINT [PK_tblQuotaGroupQuota] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblQuotaGroupQuota_tblQuotaGroup_QuotaGroupId] FOREIGN KEY ([QuotaGroupId]) REFERENCES [tblQuotaGroup] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblQuotaGroupQuota_tblReissueTypes_ReissueTypeId] FOREIGN KEY ([ReissueTypeId]) REFERENCES [tblReissueTypes] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblQuotaGroupQuota_tblStockItems_StockItemId] FOREIGN KEY ([StockItemId]) REFERENCES [tblStockItems] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE TABLE [tblEmployeeStockIssueHistory] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [EmployeeId] bigint NOT NULL,
        [StockItemId] bigint NOT NULL,
        [Quantity] decimal(18, 2) NOT NULL,
        [DateReceived] datetime2 NOT NULL,
        CONSTRAINT [PK_tblEmployeeStockIssueHistory] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblEmployeeStockIssueHistory_tblEmployees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblEmployeeStockIssueHistory_tblStockItems_StockItemId] FOREIGN KEY ([StockItemId]) REFERENCES [tblStockItems] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblDepartments_QuotaGroupId] ON [tblDepartments] ([QuotaGroupId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblDepartmentStockIssueHistory_DepartmentId] ON [tblDepartmentStockIssueHistory] ([DepartmentId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblDepartmentStockIssueHistory_StockItemId] ON [tblDepartmentStockIssueHistory] ([StockItemId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblEmployees_DepartmentId] ON [tblEmployees] ([DepartmentId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblEmployees_QuotaGroupId] ON [tblEmployees] ([QuotaGroupId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblEmployeeStockIssueHistory_EmployeeId] ON [tblEmployeeStockIssueHistory] ([EmployeeId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblEmployeeStockIssueHistory_StockItemId] ON [tblEmployeeStockIssueHistory] ([StockItemId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblQuotaGroupQuota_QuotaGroupId] ON [tblQuotaGroupQuota] ([QuotaGroupId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblQuotaGroupQuota_ReissueTypeId] ON [tblQuotaGroupQuota] ([ReissueTypeId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblQuotaGroupQuota_StockItemId] ON [tblQuotaGroupQuota] ([StockItemId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblStockItems_CategoryId] ON [tblStockItems] ([CategoryId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    CREATE INDEX [IX_tblStockItems_UnitOfMeasureId1] ON [tblStockItems] ([UnitOfMeasureId1]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806150152_InitialCreate')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190806150152_InitialCreate', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806230507_AddIsActive')
BEGIN
    ALTER TABLE [tblStockItems] ADD [IsActive] bit NOT NULL DEFAULT 0;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806230507_AddIsActive')
BEGIN
    ALTER TABLE [tblQuotaGroup] ADD [IsActive] bit NOT NULL DEFAULT 0;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806230507_AddIsActive')
BEGIN
    ALTER TABLE [tblEmployees] ADD [IsActive] bit NOT NULL DEFAULT 0;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806230507_AddIsActive')
BEGIN
    ALTER TABLE [tblDepartments] ADD [IsActive] bit NOT NULL DEFAULT 0;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190806230507_AddIsActive')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190806230507_AddIsActive', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190811120305_StockEntityChange')
BEGIN
    ALTER TABLE [tblStockItems] DROP CONSTRAINT [FK_tblStockItems_tblUnitOfMeasures_UnitOfMeasureId1];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190811120305_StockEntityChange')
BEGIN
    DROP INDEX [IX_tblStockItems_UnitOfMeasureId1] ON [tblStockItems];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190811120305_StockEntityChange')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblStockItems]') AND [c].[name] = N'UnitOfMeasureId1');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [tblStockItems] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [tblStockItems] DROP COLUMN [UnitOfMeasureId1];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190811120305_StockEntityChange')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblStockItems]') AND [c].[name] = N'UnitOfMeasureId');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [tblStockItems] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [tblStockItems] ALTER COLUMN [UnitOfMeasureId] bigint NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190811120305_StockEntityChange')
BEGIN
    CREATE INDEX [IX_tblStockItems_UnitOfMeasureId] ON [tblStockItems] ([UnitOfMeasureId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190811120305_StockEntityChange')
BEGIN
    ALTER TABLE [tblStockItems] ADD CONSTRAINT [FK_tblStockItems_tblUnitOfMeasures_UnitOfMeasureId] FOREIGN KEY ([UnitOfMeasureId]) REFERENCES [tblUnitOfMeasures] ([Id]) ON DELETE NO ACTION;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190811120305_StockEntityChange')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190811120305_StockEntityChange', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190811124700_Reinitialize')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190811124700_Reinitialize', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190822154328_CategoryIndex')
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblCategories]') AND [c].[name] = N'CategoryName');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [tblCategories] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [tblCategories] ALTER COLUMN [CategoryName] nvarchar(450) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190822154328_CategoryIndex')
BEGIN
    CREATE UNIQUE INDEX [IX_tblCategories_CategoryName] ON [tblCategories] ([CategoryName]) WHERE [CategoryName] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190822154328_CategoryIndex')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190822154328_CategoryIndex', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190826105935_ChangedtoInt')
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblEmployeeStockIssueHistory]') AND [c].[name] = N'Quantity');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [tblEmployeeStockIssueHistory] DROP CONSTRAINT [' + @var3 + '];');
    ALTER TABLE [tblEmployeeStockIssueHistory] ALTER COLUMN [Quantity] int NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190826105935_ChangedtoInt')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190826105935_ChangedtoInt', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190830210717_UserManagement')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190830210717_UserManagement', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190831042700_UserObject')
BEGIN
    CREATE TABLE [tblUsers] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [EmployeeId] bigint NOT NULL,
        [Username] nvarchar(max) NULL,
        [PasswordHash] varbinary(max) NULL,
        [PasswordSalt] varbinary(max) NULL,
        CONSTRAINT [PK_tblUsers] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblUsers_tblEmployees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190831042700_UserObject')
BEGIN
    CREATE INDEX [IX_tblUsers_EmployeeId] ON [tblUsers] ([EmployeeId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190831042700_UserObject')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190831042700_UserObject', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910132840_IsActiveCategory')
BEGIN
    ALTER TABLE [tblCategories] ADD [IsActive] bit NOT NULL DEFAULT 0;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910132840_IsActiveCategory')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190910132840_IsActiveCategory', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910133221_UniqueConstraint')
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblUnitOfMeasures]') AND [c].[name] = N'UOMDescription');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [tblUnitOfMeasures] DROP CONSTRAINT [' + @var4 + '];');
    ALTER TABLE [tblUnitOfMeasures] ALTER COLUMN [UOMDescription] nvarchar(450) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910133221_UniqueConstraint')
BEGIN
    DECLARE @var5 sysname;
    SELECT @var5 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblStockItems]') AND [c].[name] = N'StockName');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [tblStockItems] DROP CONSTRAINT [' + @var5 + '];');
    ALTER TABLE [tblStockItems] ALTER COLUMN [StockName] nvarchar(450) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910133221_UniqueConstraint')
BEGIN
    DECLARE @var6 sysname;
    SELECT @var6 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblQuotaGroup]') AND [c].[name] = N'Name');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [tblQuotaGroup] DROP CONSTRAINT [' + @var6 + '];');
    ALTER TABLE [tblQuotaGroup] ALTER COLUMN [Name] nvarchar(450) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910133221_UniqueConstraint')
BEGIN
    DECLARE @var7 sysname;
    SELECT @var7 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblDepartments]') AND [c].[name] = N'Name');
    IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [tblDepartments] DROP CONSTRAINT [' + @var7 + '];');
    ALTER TABLE [tblDepartments] ALTER COLUMN [Name] nvarchar(450) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910133221_UniqueConstraint')
BEGIN
    CREATE UNIQUE INDEX [IX_tblUnitOfMeasures_UOMDescription] ON [tblUnitOfMeasures] ([UOMDescription]) WHERE [UOMDescription] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910133221_UniqueConstraint')
BEGIN
    CREATE UNIQUE INDEX [IX_tblStockItems_StockName] ON [tblStockItems] ([StockName]) WHERE [StockName] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910133221_UniqueConstraint')
BEGIN
    CREATE UNIQUE INDEX [IX_tblQuotaGroup_Name] ON [tblQuotaGroup] ([Name]) WHERE [Name] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910133221_UniqueConstraint')
BEGIN
    CREATE UNIQUE INDEX [IX_tblDepartments_Name] ON [tblDepartments] ([Name]) WHERE [Name] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190910133221_UniqueConstraint')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190910133221_UniqueConstraint', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190926090854_EmployeeLocations')
BEGIN
    CREATE TABLE [tblLocations] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [LocationName] nvarchar(450) NULL,
        [IsActive] bit NOT NULL,
        CONSTRAINT [PK_tblLocations] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190926090854_EmployeeLocations')
BEGIN
    CREATE TABLE [tblEmployeeLocations] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL,
        [EmployeeId] bigint NOT NULL,
        [LocationId] bigint NOT NULL,
        CONSTRAINT [PK_tblEmployeeLocations] PRIMARY KEY ([EmployeeId], [LocationId]),
        CONSTRAINT [FK_tblEmployeeLocations_tblEmployees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblEmployeeLocations_tblLocations_LocationId] FOREIGN KEY ([LocationId]) REFERENCES [tblLocations] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190926090854_EmployeeLocations')
BEGIN
    CREATE INDEX [IX_tblEmployeeLocations_LocationId] ON [tblEmployeeLocations] ([LocationId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190926090854_EmployeeLocations')
BEGIN
    CREATE UNIQUE INDEX [IX_tblLocations_LocationName] ON [tblLocations] ([LocationName]) WHERE [LocationName] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190926090854_EmployeeLocations')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190926090854_EmployeeLocations', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190926114357_TopUp')
BEGIN
    CREATE TABLE [tblTopUps] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [EmployeeId] bigint NOT NULL,
        [MobileNumber] nvarchar(max) NULL,
        [TopupAmount] int NOT NULL,
        [BundleMB] int NOT NULL,
        CONSTRAINT [PK_tblTopUps] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblTopUps_tblEmployees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190926114357_TopUp')
BEGIN
    CREATE INDEX [IX_tblTopUps_EmployeeId] ON [tblTopUps] ([EmployeeId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190926114357_TopUp')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190926114357_TopUp', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190927150146_IsActiveTopup')
BEGIN
    ALTER TABLE [tblTopUps] ADD [IsActive] bit NOT NULL DEFAULT 0;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20190927150146_IsActiveTopup')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20190927150146_IsActiveTopup', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191002124703_UserRoles')
BEGIN
    ALTER TABLE [tblUsers] ADD [Role] nvarchar(max) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191002124703_UserRoles')
BEGIN
    ALTER TABLE [tblUsers] ADD [Token] nvarchar(max) NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191002124703_UserRoles')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191002124703_UserRoles', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191004100737_Modules')
BEGIN
    CREATE TABLE [tblModules] (
        [Id] bigint NOT NULL IDENTITY,
        [ModuleName] nvarchar(450) NULL,
        [IsActive] bit NOT NULL,
        CONSTRAINT [PK_tblModules] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191004100737_Modules')
BEGIN
    CREATE TABLE [tblEmployeeModules] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL,
        [EmployeeId] bigint NOT NULL,
        [ModuleId] bigint NOT NULL,
        CONSTRAINT [PK_tblEmployeeModules] PRIMARY KEY ([EmployeeId], [ModuleId]),
        CONSTRAINT [FK_tblEmployeeModules_tblEmployees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblEmployeeModules_tblModules_ModuleId] FOREIGN KEY ([ModuleId]) REFERENCES [tblModules] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191004100737_Modules')
BEGIN
    CREATE INDEX [IX_tblEmployeeModules_ModuleId] ON [tblEmployeeModules] ([ModuleId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191004100737_Modules')
BEGIN
    CREATE UNIQUE INDEX [IX_tblModules_ModuleName] ON [tblModules] ([ModuleName]) WHERE [ModuleName] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191004100737_Modules')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191004100737_Modules', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191004133731_deletedtables')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191004133731_deletedtables', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191019091011_UserIsActive')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191019091011_UserIsActive', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191111123904_DepartmentSupervisors')
BEGIN
    CREATE TABLE [tblDepartmentSupervisors] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [EmployeeId] bigint NOT NULL,
        [DepartmentId] bigint NOT NULL,
        [IsActive] bit NOT NULL,
        CONSTRAINT [PK_tblDepartmentSupervisors] PRIMARY KEY ([EmployeeId], [DepartmentId]),
        CONSTRAINT [FK_tblDepartmentSupervisors_tblDepartments_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [tblDepartments] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblDepartmentSupervisors_tblEmployees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191111123904_DepartmentSupervisors')
BEGIN
    CREATE INDEX [IX_tblDepartmentSupervisors_DepartmentId] ON [tblDepartmentSupervisors] ([DepartmentId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191111123904_DepartmentSupervisors')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191111123904_DepartmentSupervisors', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE TABLE [tblLoanStatus] (
        [Id] bigint NOT NULL IDENTITY,
        [Status] nvarchar(max) NULL,
        CONSTRAINT [PK_tblLoanStatus] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE TABLE [tblLoanApplications] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [EmployeeId] bigint NOT NULL,
        [RequestedAmount] float NOT NULL,
        [ApprovedAmount] float NOT NULL,
        [EmployeeStatusId] bigint NOT NULL,
        [ApplicationStatusId] bigint NOT NULL,
        [SupervisorId] bigint NOT NULL,
        [SupervisorStatusId] bigint NOT NULL,
        [SupervisorActionDate] datetime2 NOT NULL,
        [HROfficerId] bigint NOT NULL,
        [HROfficerStatusId] bigint NOT NULL,
        [HROfficerActionDate] datetime2 NOT NULL,
        CONSTRAINT [PK_tblLoanApplications] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblLoanApplications_tblLoanStatus_ApplicationStatusId] FOREIGN KEY ([ApplicationStatusId]) REFERENCES [tblLoanStatus] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblLoanApplications_tblEmployees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblLoanApplications_tblLoanStatus_EmployeeStatusId] FOREIGN KEY ([EmployeeStatusId]) REFERENCES [tblLoanStatus] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblLoanApplications_tblEmployees_HROfficerId] FOREIGN KEY ([HROfficerId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblLoanApplications_tblLoanStatus_HROfficerStatusId] FOREIGN KEY ([HROfficerStatusId]) REFERENCES [tblLoanStatus] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblLoanApplications_tblEmployees_SupervisorId] FOREIGN KEY ([SupervisorId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblLoanApplications_tblLoanStatus_SupervisorStatusId] FOREIGN KEY ([SupervisorStatusId]) REFERENCES [tblLoanStatus] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE TABLE [tblLoansApproved] (
        [MakerId] bigint NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [CheckerId] bigint NULL,
        [ApprovalDate] datetime2 NULL,
        [RejectionDate] datetime2 NULL,
        [Id] bigint NOT NULL IDENTITY,
        [EmployeeId] bigint NOT NULL,
        [EmployeeNumber] nvarchar(max) NULL,
        [RequestedAmount] float NOT NULL,
        [ApprovedAmount] float NOT NULL,
        [LoanApprovalDate] datetime2 NOT NULL,
        [LoanStatusId] bigint NOT NULL,
        CONSTRAINT [PK_tblLoansApproved] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_tblLoansApproved_tblEmployees_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [tblEmployees] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_tblLoansApproved_tblLoanStatus_LoanStatusId] FOREIGN KEY ([LoanStatusId]) REFERENCES [tblLoanStatus] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Status') AND [object_id] = OBJECT_ID(N'[tblLoanStatus]'))
        SET IDENTITY_INSERT [tblLoanStatus] ON;
    INSERT INTO [tblLoanStatus] ([Id], [Status])
    VALUES (CAST(1 AS bigint), N'Approved'),
    (CAST(2 AS bigint), N'Draft'),
    (CAST(3 AS bigint), N'In Progress'),
    (CAST(4 AS bigint), N'Pending'),
    (CAST(5 AS bigint), N'Rejected'),
    (CAST(6 AS bigint), N'Submitted');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Status') AND [object_id] = OBJECT_ID(N'[tblLoanStatus]'))
        SET IDENTITY_INSERT [tblLoanStatus] OFF;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE INDEX [IX_tblLoanApplications_ApplicationStatusId] ON [tblLoanApplications] ([ApplicationStatusId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE INDEX [IX_tblLoanApplications_EmployeeId] ON [tblLoanApplications] ([EmployeeId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE INDEX [IX_tblLoanApplications_EmployeeStatusId] ON [tblLoanApplications] ([EmployeeStatusId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE INDEX [IX_tblLoanApplications_HROfficerId] ON [tblLoanApplications] ([HROfficerId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE INDEX [IX_tblLoanApplications_HROfficerStatusId] ON [tblLoanApplications] ([HROfficerStatusId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE INDEX [IX_tblLoanApplications_SupervisorId] ON [tblLoanApplications] ([SupervisorId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE INDEX [IX_tblLoanApplications_SupervisorStatusId] ON [tblLoanApplications] ([SupervisorStatusId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE INDEX [IX_tblLoansApproved_EmployeeId] ON [tblLoansApproved] ([EmployeeId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    CREATE INDEX [IX_tblLoansApproved_LoanStatusId] ON [tblLoansApproved] ([LoanStatusId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112144937_LoansInformation')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191112144937_LoansInformation', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112192820_LoanApplicationTrigger')
BEGIN
    CREATE TRIGGER dbo.trgAfterLoanApplicationApproval_InsertIntoLoansApproved 
       ON  dbo.tblLoanApplications 
       AFTER UPDATE
    AS 
    BEGIN
    	-- SET NOCOUNT ON added to prevent extra result sets from
    	-- interfering with SELECT statements.
    	SET NOCOUNT ON;

        -- Insert statements for trigger here
    	INSERT INTO dbo.tblLoansApproved
    	([MakerId]
          ,[SubmissionDate]
          ,[CheckerId]
          ,[ApprovalDate]
          ,[RejectionDate]
    	  ,[EmployeeId]
          ,[EmployeeNumber]
          ,[RequestedAmount]
          ,[ApprovedAmount]
          ,[LoanApprovalDate]
          ,[LoanStatusId])
    	  SELECT i.MakerId
    	  ,i.[SubmissionDate]
          ,i.[CheckerId]
          ,i.[ApprovalDate]
          ,i.[RejectionDate]
    	  ,i.[EmployeeId]
    	  ,(SELECT e.EmployeeNumber FROM dbo.tblEmployees e WHERE e.Id = i.EmployeeId)
    	  ,i.[RequestedAmount]
          ,i.[ApprovedAmount]
          ,GETDATE()
          ,3 -- In Progress. This will be changed to paid
    	  FROM inserted i
    		INNER JOIN
    		deleted
    			ON i.Id = deleted.Id
            -- It's an update if the record is in BOTH inserted AND deleted
    	  WHERE i.ApplicationStatusId = 1 --Approved 
    END
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191112192820_LoanApplicationTrigger')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191112192820_LoanApplicationTrigger', N'2.1.14-servicing-32113');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191113055806_NullableLoanFields')
BEGIN
    DECLARE @var8 sysname;
    SELECT @var8 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblLoanApplications]') AND [c].[name] = N'SupervisorStatusId');
    IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [tblLoanApplications] DROP CONSTRAINT [' + @var8 + '];');
    ALTER TABLE [tblLoanApplications] ALTER COLUMN [SupervisorStatusId] bigint NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191113055806_NullableLoanFields')
BEGIN
    DECLARE @var9 sysname;
    SELECT @var9 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblLoanApplications]') AND [c].[name] = N'SupervisorId');
    IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [tblLoanApplications] DROP CONSTRAINT [' + @var9 + '];');
    ALTER TABLE [tblLoanApplications] ALTER COLUMN [SupervisorId] bigint NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191113055806_NullableLoanFields')
BEGIN
    DECLARE @var10 sysname;
    SELECT @var10 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblLoanApplications]') AND [c].[name] = N'SupervisorActionDate');
    IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [tblLoanApplications] DROP CONSTRAINT [' + @var10 + '];');
    ALTER TABLE [tblLoanApplications] ALTER COLUMN [SupervisorActionDate] datetime2 NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191113055806_NullableLoanFields')
BEGIN
    DECLARE @var11 sysname;
    SELECT @var11 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblLoanApplications]') AND [c].[name] = N'HROfficerStatusId');
    IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [tblLoanApplications] DROP CONSTRAINT [' + @var11 + '];');
    ALTER TABLE [tblLoanApplications] ALTER COLUMN [HROfficerStatusId] bigint NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191113055806_NullableLoanFields')
BEGIN
    DECLARE @var12 sysname;
    SELECT @var12 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblLoanApplications]') AND [c].[name] = N'HROfficerId');
    IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [tblLoanApplications] DROP CONSTRAINT [' + @var12 + '];');
    ALTER TABLE [tblLoanApplications] ALTER COLUMN [HROfficerId] bigint NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191113055806_NullableLoanFields')
BEGIN
    DECLARE @var13 sysname;
    SELECT @var13 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tblLoanApplications]') AND [c].[name] = N'HROfficerActionDate');
    IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [tblLoanApplications] DROP CONSTRAINT [' + @var13 + '];');
    ALTER TABLE [tblLoanApplications] ALTER COLUMN [HROfficerActionDate] datetime2 NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20191113055806_NullableLoanFields')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20191113055806_NullableLoanFields', N'2.1.14-servicing-32113');
END;

GO

