-- delete all tables if they already exist
IF OBJECT_ID('Messages', 'U') IS NOT NULL DROP TABLE Messages;
IF OBJECT_ID('ServerMembers', 'U') IS NOT NULL DROP TABLE ServerMembers;
IF OBJECT_ID('Channels', 'U') IS NOT NULL DROP TABLE Channels;
IF OBJECT_ID('Servers', 'U') IS NOT NULL DROP TABLE Servers;
IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users;

-- table creation
CREATE TABLE Servers (
    ServerId INT IDENTITY(1,1) PRIMARY KEY,
    ServerName NVARCHAR(40) NOT NULL
);

CREATE TABLE Channels (
    ChannelId INT IDENTITY(1,1) PRIMARY KEY,
    ChannelName NVARCHAR(40) NOT NULL,
    ServerId INT NOT NULL,
    CONSTRAINT fk_channel_server FOREIGN KEY(ServerId) REFERENCES Servers(ServerId)
);

CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(40) NOT NULL,
    UserPassword NVARCHAR(100)
);

CREATE TABLE ServerMembers(
    ServerMemberId INT IDENTITY(1,1) PRIMARY KEY,
    ServerId INT NOT NULL,
    UserId INT NOT NULL,
    CONSTRAINT fk_server_member_server FOREIGN KEY(ServerId) REFERENCES Servers(ServerId),
    CONSTRAINT fk_server_member_user FOREIGN KEY(UserId) REFERENCES Users(UserId)
);

CREATE TABLE Messages (
    MessageId INT IDENTITY(1,1) PRIMARY KEY,
    ChannelId INT NOT NULL,
    UserId INT NOT NULL,
    CreationTime DATETIME NOT NULL,
    MessageContent NVARCHAR(1000),
    CONSTRAINT fk_message_channel FOREIGN KEY(ChannelId) REFERENCES Channels(ChannelId),
    CONSTRAINT fk_message_user FOREIGN KEY(UserId) REFERENCES Users(UserId)
);


-- initialize sample data
INSERT INTO Servers (ServerName)
VALUES('test');

INSERT INTO Channels (ChannelName, ServerId)
VALUES('general', 1),
('csgo', 1),
('genshin', 1);

INSERT INTO Users (UserName)
VALUES('Tom'),
('Jim');

INSERT INTO ServerMembers (ServerId, UserId)
VALUES (1, 1),
(1, 2);