/*
	Unfortunately, it's surprisingly a little tricky for a web page to go get JSON data on any but its own URL due to browser restrictions cross-domain data access.
	You can either configure the server serving the JSON to send CORS headers to authorize this activity,
		or you can use a workaround called JSONP, where you refer to the external data using a script tag, and it executes actual script
		which either calls a function or sets a variable.
	Our "data file" thus has to have that cruft in it, which we need to filter out below.
*/

DECLARE
	@JSONPWrapperStart nvarchar(100) = N'var TSQLTuesdayData = JSON.parse(''',
	@JSONPWrapperStop nvarchar(100) = N''');';

/*
	You should place the file contents here, but be sure to alias any single quotes to double single quotes.
	If you have the raw JSON already somehow, you can put it directly in @j below.
*/

DECLARE
	@FileData nvarchar(max) = N'var TSQLTuesdayData = JSON.parse(''{"TSQLTuesday":[{"Parties":[{"PartyID":72,"PartyDate":"2015-11-10","PartyTitle":"Data Modeling Gone Wrong","PartyAuthorID":"MS0001","PartyInviteURL":"http:\/\/mickeystuewe.com\/2015\/11\/03\/t-sql-tuesday-72-invitation-data-modeling-gone-wrong\/","PartyURL":"http:\/\/mickeystuewe.com\/2015\/11\/16\/t-sql-tuesday-72-summarydata-modeling-gone-wrong\/","PartyDesc":"I would like to invite you to share some data modeling practices that should be avoided, and how to fix them when they do occur."},{"PartyID":73,"PartyDate":"2015-12-08","PartyTitle":"Naughty or Nice?","PartyAuthorID":"BB0001","PartyInviteURL":"http:\/\/www.sqlballs.com\/2015\/12\/t-sql-tuesday-73-invitation-naughty-or.html","PartyURL":"","PartyDesc":"As you work with SQL Server look around you. Is your environment Naughty or Nice?"},{"PartyID":74,"PartyDate":"2016-01-12","PartyTitle":"Be the Change","PartyAuthorID":"RD0001","PartyInviteURL":"http:\/\/www.sqlsoldier.com\/wp\/sqlserver\/tsqltuesday74invitationbethechange","PartyURL":"http:\/\/www.sqlsoldier.com\/wp\/sqlserver\/tsqltuesday74bethechangeroundup","PartyDesc":"How do you track changing data? How do you do your ETL? How do you clean or scrub your data? Anything related to changing data."},{"PartyID":75,"PartyDate":"2016-02-09","PartyTitle":"Power BI","PartyAuthorID":"JS0001","PartyInviteURL":"http:\/\/www.sqlchicken.com\/2016\/02\/t-sql-tuesday-75-invitation-jump-into-power-bi\/","PartyURL":"http:\/\/www.sqlchicken.com\/2016\/02\/t-sql-tuesday-75-round-up\/","PartyDesc":"Your challenge, if you choose to accept it, is to create and publish your very own Power BI report!"},{"PartyID":76,"PartyDate":"2016-03-08","PartyTitle":"Text Searching\/Processing","PartyAuthorID":"BP0001","PartyInviteURL":"http:\/\/www.bobpusateri.com\/archive\/2016\/02\/invitation-to-t-sql-tuesday-76-text-searchingprocessing\/","PartyURL":"http:\/\/www.bobpusateri.com\/archive\/2016\/03\/t-sql-tuesday-76-wrap-up\/","PartyDesc":"If you�re using SQL Server Full-Text Search, I�d love to hear from you. But I�d also love to hear from anyone using any other kind of text searching or processing methods."},{"PartyID":77,"PartyDate":"2016-04-12","PartyTitle":"Favorite SQL Server Feature","PartyAuthorID":"JV0001","PartyInviteURL":"http:\/\/t-sql.dk\/?p=1492","PartyURL":"http:\/\/t-sql.dk\/?p=1584","PartyDesc":"The topic is: What is My Favorite SQL Server Feature.This can be anything from Reporting Services as a report creating tool, down to the Columnstore Indexes. Anything goes! I selected this topic precisely to illustrate the breadth and depth of what SQL Server has evolved into over the last decade+."},{"PartyID":78,"PartyDate":"2016-05-10","PartyTitle":"Learn Something New","PartyAuthorID":"WP0001","PartyInviteURL":"http:\/\/wendyverse.blogspot.com\/2016\/04\/its-time-for-t-sql-tuesday-78-may-2016.html","PartyURL":"","PartyDesc":"I�m challenging you to learn something new and blog about it!"},{"PartyID":79,"PartyDate":"2016-06-14","PartyTitle":"It�s 2016","PartyAuthorID":"MS0002","PartyInviteURL":"http:\/\/michaeljswart.com\/2016\/06\/t-sql-tuesday-079-its-2016\/","PartyURL":"http:\/\/michaeljswart.com\/2016\/06\/t-sql-tuesday-079-roundup-its-2016\/","PartyDesc":"SQL Server 2016 went RTM this week and so naturally, we�re going to write about it."},{"PartyID":80,"PartyDate":"2016-07-12","PartyTitle":"My Birthday","PartyAuthorID":"CY0001","PartyInviteURL":"http:\/\/www.toadworld.com\/platforms\/sql-server\/b\/weblog\/archive\/2016\/07\/06\/t-sql-tuesday-080","PartyURL":"https:\/\/chrisyatessql.wordpress.com\/2016\/07\/19\/t-sql-tuesday-080-round-up\/","PartyDesc":"Treat yourself to a birthday gift and come up with a present for yourself SQL related � no limitations."},{"PartyID":81,"PartyDate":"2016-08-09","PartyTitle":"Sharpen Something","PartyAuthorID":"JB0001","PartyInviteURL":"http:\/\/jasonbrimhall.info\/2016\/07\/27\/t-sql-tuesday-081-sharpen-something\/","PartyURL":"http:\/\/jasonbrimhall.info\/2016\/08\/18\/t-sql-tuesday-081-recap\/","PartyDesc":"This month I am asking you to not only write a post but to do a little homework � first. In other words, plan to do something, carry out that plan, and then write about the experience."},{"PartyID":82,"PartyDate":"2016-09-13","PartyTitle":"To the Cloud� And Beyond!","PartyAuthorID":"JV0002","PartyInviteURL":"https:\/\/devjef.wordpress.com\/2016\/09\/06\/invitation-t-sql-tuesday-82-to-the-cloud-and-beyond\/","PartyURL":"","PartyDesc":"When Adam asked me if I wanted to host another T-SQL Tuesday, I immediately knew a topic I wanted to talk about: The cloud, and (if you want to) specifically about Azure SQL database."},{"PartyID":83,"PartyDate":"2016-10-11","PartyTitle":"We�re Still Dealing with the Same Old Problems","PartyAuthorID":"AM0001","PartyInviteURL":"http:\/\/am2.co\/2016\/10\/t-sql-tuesday-83\/","PartyURL":"http:\/\/am2.co\/2016\/10\/t-sql-tuesday-83-roundup\/","PartyDesc":"I offer two fill-in-the-blank topics: In the years I have been a database professional, we�re still dealing with� In the years I have been using SQL Server, we�re still dealing with"},{"PartyID":84,"PartyDate":"2016-11-08","PartyTitle":"Growing New Speakers","PartyAuthorID":"AY0001","PartyInviteURL":"https:\/\/sqlbek.wordpress.com\/2016\/10\/25\/t-sql-tuesday-84-growing-new-speakers\/","PartyURL":"https:\/\/sqlbek.wordpress.com\/2016\/11\/15\/t-sql-tuesday-84-growing-new-speakers-round-up\/","PartyDesc":"For T-SQL Tuesday, I am giving differing topics if you are currently a Speaker or have never have spoken.If you are a presenter, help new speakers. If you have never spoken, start thinking about your first presentation."},{"PartyID":85,"PartyDate":"2016-12-13","PartyTitle":"Backup and Recovery","PartyAuthorID":"KF0001","PartyInviteURL":"https:\/\/sqlstudies.com\/2016\/12\/06\/4169\/","PartyURL":"https:\/\/sqlstudies.com\/2016\/12\/26\/a-semesters-worth-of-backup-and-recovery-blogs-the-tsql-tuesday-85-rollup\/","PartyDesc":"Backups are one of the most common things DBAs discuss, and they are at once one of the simplest and most complicated parts of our whole job. So let�s hear it for backup and recovery!"},{"PartyID":86,"PartyDate":"2017-01-09","PartyTitle":"SQL Server Bugs and Enhancement Requests","PartyAuthorID":"BO0001","PartyInviteURL":"https:\/\/www.brentozar.com\/archive\/2017\/01\/announcing-t-sql-tuesday-87-sql-server-bugs-enhancement-requests\/","PartyURL":"https:\/\/www.brentozar.com\/archive\/2017\/01\/favorite-bugs-enhancement-requests-tsql2sday-86-roundup\/","PartyDesc":"Find the most interesting bug or enhancement request (and it can be your own), and write a blog post about it"},{"PartyID":87,"PartyDate":"2017-02-14","PartyTitle":"Fixing Old Problems with Shiny New Toys","PartyAuthorID":"MG0001","PartyInviteURL":"https:\/\/sqlatspeed.com\/2017\/02\/07\/announcing-t-sql-tuesday-87\/","PartyURL":"https:\/\/sqlatspeed.com\/2017\/02\/17\/t-sql-tuesday-87-the-roundup\/","PartyDesc":"What I�d like to see from the blog responses for this T-SQL Tuesday is how you�ve used a �new� Microsoft data platform toy to fix an old problem. We�ll define new toys as something from SQL Server 2014�s release date until now. We�ll even accept a SQL Server vNext response if you�ve got one!"}],"Authors":[{"AuthorID":"AM0001","AuthorName":"Andy M Mallon","AuthorTwitter":"https:\/\/www.am2.co\/","AuthorBlogURL":"@AMtwo"},{"AuthorID":"AY0001","AuthorName":"Andy Yun","AuthorTwitter":"https:\/\/sqlbek.wordpress.com\/","AuthorBlogURL":"@SQLBek"},{"AuthorID":"BB0001","AuthorName":"Bradley Ball","AuthorTwitter":"http:\/\/www.sqlballs.com","AuthorBlogURL":"@SQLBalls"},{"AuthorID":"BO0001","AuthorName":"Brent Ozar","AuthorTwitter":"https:\/\/www.brentozar.com\/","AuthorBlogURL":"@BrentO"},{"AuthorID":"BP0001","AuthorName":"Bob Pusateri","AuthorTwitter":"http:\/\/www.bobpusateri.com\/","AuthorBlogURL":"@SQLBob"},{"AuthorID":"CY0001","AuthorName":"Chris Yates�","AuthorTwitter":"https:\/\/chrisyatessql.wordpress.com\/","AuthorBlogURL":"@YatesSQL"},{"AuthorID":"JB0001","AuthorName":"Jason Brimhall","AuthorTwitter":"http:\/\/jasonbrimhall.info\/","AuthorBlogURL":"@sqlrnnr"},{"AuthorID":"JS0001","AuthorName":"Jorge Segarra","AuthorTwitter":"http:\/\/www.sqlchicken.com\/","AuthorBlogURL":"@SQLChicken"},{"AuthorID":"JV0001","AuthorName":"Jens Vestergaard","AuthorTwitter":"http:\/\/t-sql.dk\/","AuthorBlogURL":"@vestergaardj"},{"AuthorID":"JV0002","AuthorName":"Jeffrey Verheul","AuthorTwitter":"https:\/\/devjef.wordpress.com\/","AuthorBlogURL":"@DevJef"},{"AuthorID":"KF0001","AuthorName":"Kenneth Fisher","AuthorTwitter":"https:\/\/sqlstudies.com\/","AuthorBlogURL":"@sqlstudent144"},{"AuthorID":"MG0001","AuthorName":"Matt Gordon","AuthorTwitter":"https:\/\/sqlatspeed.com\/","AuthorBlogURL":"@sqlatspeed"},{"AuthorID":"MS0001","AuthorName":"Mickey Stuewe","AuthorTwitter":"http:\/\/mickeystuewe.com","AuthorBlogURL":"@SQLMickey"},{"AuthorID":"MS0002","AuthorName":"Michael J. Swart","AuthorTwitter":"http:\/\/michaeljswart.com\/","AuthorBlogURL":"@MJSwart"},{"AuthorID":"RD0001","AuthorName":"Robert L Davis","AuthorTwitter":"http:\/\/sqlsoldier.net\/","AuthorBlogURL":"@SQLSoldier"},{"AuthorID":"WP0001","AuthorName":"Wendy Pastrick","AuthorTwitter":"https:\/\/wendyverse.blogspot.com\/","AuthorBlogURL":"@wendy_dance"}]}]}'');';

DECLARE
	@j nvarchar(max) = SUBSTRING(@FileData,LEN(@JSONPWrapperStart)+1,LEN(@FileData)-(LEN(@JSONPWrapperStart) + LEN(@JSONPWrapperStop)));

/* This sets up two table variables and imports the JSON data into them. It does no data modification so it should be safe to run. */

DECLARE @Parties TABLE
(
	PartyID INT PRIMARY KEY,
	PartyDate date,
	PartyTitle nvarchar(500),
	PartyAuthorID varchar(10),
	PartyInviteURL varchar(500),
	PartyURL varchar(500),
	PartyDesc nvarchar(max)
);

DECLARE @Authors TABLE
(
	AuthorID varchar(50) PRIMARY KEY,
	AuthorName nvarchar(200),
	AuthorTwitter nvarchar(50),
	AuthorBlogURL varchar(500)
);

INSERT INTO @Parties
(
	PartyID, PartyDate, PartyTitle, PartyAuthorID, PartyInviteURL, PartyURL, PartyDesc
)
SELECT
	PartyID, PartyDate, PartyTitle, PartyAuthorID, PartyInviteURL, PartyURL, PartyDesc
FROM		(
				SELECT
					JSON_VALUE(pjsonlist.[value],'$.PartyID') AS PartyID,
					JSON_VALUE(pjsonlist.[value],'$.PartyDate') AS PartyDate,
					JSON_VALUE(pjsonlist.[value],'$.PartyTitle') AS PartyTitle,
					JSON_VALUE(pjsonlist.[value],'$.PartyAuthorID') AS PartyAuthorID,
					JSON_VALUE(pjsonlist.[value],'$.PartyInviteURL') AS PartyInviteURL,
					JSON_VALUE(pjsonlist.[value],'$.PartyURL') AS PartyURL,
					JSON_VALUE(pjsonlist.[value],'$.PartyDesc') AS PartyDesc
				FROM	OPENJSON(@j,'$.TSQLTuesday[0].Parties') pjsonlist
			) AS t;

INSERT INTO @Authors
(
	AuthorID, AuthorName, AuthorTwitter, AuthorBlogURL
)
SELECT
	AuthorID, AuthorName, AuthorTwitter, AuthorBlogURL
FROM		(
				SELECT
					JSON_VALUE(ajsonlist.[value],'$.AuthorID') AS AuthorID,
					JSON_VALUE(ajsonlist.[value],'$.AuthorName') AS AuthorName,
					JSON_VALUE(ajsonlist.[value],'$.AuthorTwitter') AS AuthorTwitter,
					JSON_VALUE(ajsonlist.[value],'$.AuthorBlogURL') AS AuthorBlogURL
				FROM	OPENJSON(@j,'$.TSQLTuesday[0].Authors') ajsonlist
			) AS t;

/* Here is where you can play with the data, querying or altering it... */

SELECT		*
FROM		@Parties p
JOIN		@Authors a
ON			p.PartyAuthorID = a.AuthorID;

/*
	This reforms the data into JSON with the format we are expecting.
	If you have altered data, copy the resulting JSON into the data file in your repo and submit a pull request to get the official copy updated.

	Multiple versions of the JSON are made available.
		If you are putting the JSON into the official data file, use FileJSON.
		If you are putting the JSON into the SQL above for testing,
			use FileJSONSQLFriendly for @FileData or RawJSONSQLFriendly for @j directly.
		If you are using the JSON somewhere else (e.g. a web formatting tool), use RawJSON.
*/

SELECT
	@JSONPWrapperStart + t.RawJSON + @JSONPWrapperStop AS FileJSON,
	@JSONPWrapperStart + t.RawJSON + @JSONPWrapperStop AS FileJSONSQLFriendly,
	t.RawJSON AS RawJSON,
	REPLACE(t.RawJSON,'''','''''') AS RawJSONSQLFriendly
FROM		(
				SELECT
					(
						SELECT
							(
								SELECT		*
								FROM		@Parties
								FOR JSON PATH
							) AS Parties,
							(
								SELECT		*
								FROM		@Authors
								FOR JSON PATH
							) AS Authors
						FOR JSON PATH, ROOT('TSQLTuesday')
					) AS RawJSON
			) AS t;