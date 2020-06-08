use javadb;
#1.Creating table users with fileds
create table users(usersId bigint auto_increment primary key
,emailId varchar(225) not null,
password varchar(225) not null
,roll varchar(225) not null
,username varchar(225) not null
,fristname varchar(225) not null
,lastname varchar(225) not null
,mobilenumber bigint not null);
 #1.1 Insertind data 
 insert into users(emailId,password,roll,username,fristname,lastname,mobilenumber) values(?,?,?,?,?,?,?);
 #1.2 delating tabel 
 drop table users;
 #1.3 retrive the roll of users
 select users.roll from users where  emailId="" AND password="";

################################################################################################################################################
#2.Creating project  table
create table project(projectId bigint auto_increment primary key,projectName varchar(225));
#2.1 inserting table  query
insert into project(projectName) values(?);
#2.2  deleating row or project
delete from  project where projectName="";
#2.3 deleting table
drop  table project ;
################################################################################################################################################
#3.Creating table Relation with project and user ,it means which project ? which user working to track help of these table
create table  groupingProject(
project_id bigint
,user_id bigint
,primary key(project_Id,user_Id)
,foreign key (project_Id) references project(projectId) on delete cascade
,foreign key  (user_Id) references  users(usersId )on delete cascade
);
#3.1 inserting value groupingProject
insert into groupingProject(project_id,user_id) values(?,?);
#3.2 delate row project
delete from  groupingProject where projectName="" or user_id="";
################################################################################################################################################

#4.Creating issuetype table 
create table  issueType(issueTypeid int primary key auto_increment,issueType varchar(225));
select * from issueType;
#4.1 inserting data into issuetpe table query
insert into issueType(issueType) values("Task");
insert into issueType(issueType) values("Bug");
insert into issueType(issueType) values("Epic");
#4.2 drop the table 
drop  table issueType;


################################################################################################################################################
#5.Creating  Statuticket table
create table statusTicket(statusTicketId int primary key auto_increment,statusTicket varchar(225));
#Inserting table data
insert into statusTicket(statusTicket)  values("Open");
insert into statusTicket(statusTicket)  values("Work-in-progress");
insert into statusTicket(statusTicket)  values("Pending");
insert into statusTicket(statusTicket)  values("Close");
insert into statusTicket(statusTicket)  values("Reopen");
select * from statusTicket;
################################################################################################################################################
#6.Creating priorityType table
create table priorityType(prioriTypeId int primary key auto_increment ,priority varchar(225));
#6.1 Insert into data in table 
insert into priorityType(priority) values("Low");
insert into priorityType(priority) values("Medium");
insert into priorityType(priority) values("High");
#6.2 droping table
drop table  priorityType;
################################################################################################################################################
#7.Creating table for IssueTracker
create table issuseTracker(issuertrackerid bigint primary key auto_increment
,projectLinkId bigint
,issuetypeLinkId int
,priorityLinkId int
,statusTicket int
,rollUser varchar(225)
,AssignedBy varchar(225)
,AssigneeTo varchar(225)
,summary varchar(225)
,issueDescription varchar(225)
,issueDate varchar(225)
,closedDate varchar(225)
,foreign key (projectLinkId) references project(projectId) on delete set null
,foreign key (issuetypeLinkId) references issueType(issueTypeid) on delete set null
,foreign key (priorityLinkId) references priorityType(prioriTypeId) on delete set null
,foreign key  (statusTicket) references  statusTicket(statusTicketId) on delete set null
);
#7.5 droping table
drop  table issuseTracker;
#7.6 Inserting data into table
insert into issuseTracker (projectLinkId,issuetypeLinkId,priorityLinkId,statusTicket,rollUser,AssignedBy,AssigneeTo,summary,issueDescription,,issueDate,closedDate) values(?,?,?,?,?,?,?,?,?,?,?);

#7.1 retriving rolle by the data using joins 

SELECT  * FROM issuseTracker
INNER JOIN project
ON  issuseTracker.projectLinkId =project.projectId
INNER JOIN statusticket 
ON  issuseTracker.statusTicket=statusTicket.statusTicketId
INNER JOIN issuetype
ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid
INNER JOIN prioritytype
ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId
WHERE  issuseTracker.rollUser="" 
;

#7.2 retrive data Open ticket and developer
SELECT  * FROM issuseTracker
INNER JOIN project
ON  issuseTracker.projectLinkId =project.projectId
INNER JOIN statusticket 
ON  issuseTracker.statusTicket=statusTicket.statusTicketId
INNER JOIN issuetype
ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid
INNER JOIN prioritytype
ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId
WHERE  issuseTracker.rollUser=""  AND issuseTracker.statusTicket="";
;
#7.3 retrive the date by protity

SELECT  * FROM issuseTracker
INNER JOIN project
ON  issuseTracker.projectLinkId =project.projectId
INNER JOIN statusticket 
ON  issuseTracker.statusTicket=statusTicket.statusTicketId
INNER JOIN issuetype
ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid
INNER JOIN prioritytype
ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId
WHERE  issuseTracker.rollUser=""  AND issuseTracker.priority="";
;
#7.4 retrive the date by issuetype
SELECT  issusetracker.issuertrackerid,project.projectName,issuetype.issueType,statusticket.statusTicket
,issusetracker.rollUser,issusetracker.AssignedBy,issusetracker.AssigneeTo,issusetracker.summary,issusetracker,issueDescription
,issusetracker.issueDate,issusetracker.closedDate
INNER JOIN project
ON  issuseTracker.projectLinkId =project.projectId
INNER JOIN statusticket 
ON  issuseTracker.statusTicket=statusTicket.statusTicketId
INNER JOIN issuetype
ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid
INNER JOIN prioritytype
ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId
WHERE  issuseTracker.rollUser=""  AND issuseTracker.issueType="";
;

#7.7 modify
UPDATE issuseTracker  
SET   statusTicket ="", AssignedBy="" ,closedDate =""
WHERE issuseTracker.issuertrackerid="" ;

#7.1 specific column and where condition
SELECT  issusetracker.issuertrackerid,project.projectName,issuetype.issueType,statusticket.statusTicket
,rollUser,AssignedBy,AssigneeTo,summary,issueDescription
,issueDate,closedDate
 FROM issuseTracker
INNER JOIN project
ON  issuseTracker.projectLinkId =project.projectId
INNER JOIN statusticket 
ON  issuseTracker.statusTicket=statusTicket.statusTicketId
INNER JOIN issuetype
ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid
INNER JOIN prioritytype
ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId
WHERE  issuseTracker.rollUser=""  AND issuseTracker.priority="";



"SELECT issusetracker.issuertrackerid,project.projectName,issuetype.issueType,statusticket.statusTicket,rollUser,AssignedBy,AssigneeTo,summary,issueDescription,issueDate,closedDate FROM issuseTracker INNER JOIN project ON  issuseTracker.projectLinkId =project.projectId INNER JOIN statusticket ON  issuseTracker.statusTicket=statusTicket.statusTicketId INNER JOIN issuetype ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid INNER JOIN prioritytype ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId WHERE  issuseTracker.rollUser= ' " + rs.get() +" 'AND issuseTracker.priority= ' " + rs.get() +" ' ";

	
 String sql = "SELECT issusetracker.issuertrackerid,project.projectName,issuetype.issueType,prioritytype.priority,statusticket.statusTicket,rollUser,AssignedBy,AssigneeTo,summary,issueDescription,issueDate,closedDate FROM issuseTracker INNER JOIN project ON  issuseTracker.projectLinkId =project.projectId INNER JOIN statusticket ON  issuseTracker.statusTicket=statusTicket.statusTicketId INNER JOIN issuetype ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid INNER JOIN prioritytype ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId WHERE  issuseTracker.rollUser= ' " + iT.getRollUser() +" 'AND statusticket.statusTicket= ' " + iT.getPriorityLinkID() +" ' ";

String sql = "SELECT issusetracker.issuertrackerid,project.projectName,issuetype.issueType,prioritytype.priority,statusticket.statusTicket,rollUser,AssignedBy,AssigneeTo,summary,issueDescription,issueDate,closedDate FROM issuseTracker INNER JOIN project ON  issuseTracker.projectLinkId =project.projectId INNER JOIN statusticket ON  issuseTracker.statusTicket=statusTicket.statusTicketId INNER JOIN issuetype ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid INNER JOIN prioritytype ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId WHERE  issuseTracker.rollUser= ' " + iT.getRollUser() +" 'AND issuetype.issueType= ' " + iT.getPriorityLinkID() +" ' ";


 String sql = "SELECT issusetracker.issuertrackerid,project.projectName,issuetype.issueType,prioritytype.priority,statusticket.statusTicket,rollUser,AssignedBy,AssigneeTo,summary,issueDescription,issueDate,closedDate FROM issuseTracker INNER JOIN project ON  issuseTracker.projectLinkId =project.projectId INNER JOIN statusticket ON  issuseTracker.statusTicket=statusTicket.statusTicketId INNER JOIN issuetype ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid INNER JOIN prioritytype ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId WHERE  issuseTracker.rollUser= ' " + iT.getRollUser() +" ' ";

 
 
 UPDATE issuseTracker  
SET   projectLinkIdissuetypeLinkId="",statusTicket ="", priorityLinkId="",rollUser="",AssignedBy="" ,AssigneeTo="",closedDate =""
WHERE id="" ;

##########################################################################################################################################33333





SELECT  issusetracker.issuertrackerid,project.projectName,prioritytype.priority,issuetype.issueType,statusticket.statusTicket
,rollUser,AssignedBy,AssigneeTo,summary,issueDescription
,issueDate,closedDate
 FROM issuseTracker
INNER JOIN project
ON  issuseTracker.projectLinkId =project.projectId
INNER JOIN statusticket 
ON  issuseTracker.statusTicket=statusTicket.statusTicketId
INNER JOIN issuetype
ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid
INNER JOIN prioritytype
ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId  +
"WHERE" + "issuseTracker.rollUser= " + "Admin" ;



############################################################################################################################
"select project.projectId,project.projectName  from users 
INNER JOIN groupingproject
ON  users.usersId =groupingproject.user_id
INNER JOIN project 
ON  groupingproject.project_id=project.projectId
where users.usersId=2;"
##########################################################################################################################
select users.usersId,users.emailId,users.username,project.projectId,project.projectName from users 
INNER JOIN groupingproject
ON  users.usersId =groupingproject.user_id
INNER JOIN project 
ON  groupingproject.project_id=project.projectId
######################################################################################################################
SELECT  project.projectName,issusetracker.issuertrackerid,prioritytype.priority,issuetype.issueType,statusticket.statusTicket
,rollUser,AssignedBy,AssigneeTo,summary,issueDescription
,issueDate,closedDate FROM  project
LEFT JOIN issuseTracker
ON  issuseTracker.projectLinkId =project.projectId
LEFT JOIN statusticket 
ON  issuseTracker.statusTicket=statusTicket.statusTicketId
LEFT JOIN issuetype
ON issuseTracker.issuetypeLinkId=issuetype.issueTypeid
LEFT JOIN prioritytype
ON issuseTracker.priorityLinkId=prioritytype.prioriTypeId