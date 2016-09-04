/** Question 1:  Find the number of emails that mention “Obama” in the ExtractedBodyText of the email. **/
Select count(*) from Emails where ExtractedBodyText like "%Obama%";

/** Question 2: Among people with Aliases, find the average number of Aliases each person has. **/
Select avg(numAliases) FROM (select P.id, count(*) as numAliases from Aliases as A, Persons as P where A.personID = P.id group by P.id) as R;

/** Question 3: Find the MetadataDateSent on which the most emails were sent and the number of emails that were sent on * that date. Note that that many emails do not have a date -- don’t include those in your count. **/
select MetadataDateSent, numSent from (select MetadataDateSent, count(MetadataDateSent) as numSent from emails where MetadataDateSent != null group by MetadataDateSent ) order by numSent desc limit 1;

/** Question 4: Find out how many distinct ids refer to Hillary Clinton. Remember the hint from the homework spec! **/
select count(Name) from Aliases as A left join Persons as P on A.personID=P.id where P.name = "Hillary Clinton";

/** Question 5: Find the number of emails in the database sent by Hillary Clinton. Keep in mind that there are multiple * aliases (from the previous question) that the email could’ve been sent from. **/
select count(E.SenderPersonId) from Emails as E, Persons as P where E.SenderPersonId=P.id and p.name = "Hillary Clinton";

/** Question 6: Find the names of the 5 people who emailed Hillary Clinton the most. **/
select P.name, C.numMail from (select E.SenderPersonId, count(*) as numMail from Emails as E, EmailReceivers as R where R.PersonID=80 and R.EmailId=E.id group by E.SenderPersonId) as C, Persons as P where P.id=C.SenderPersonId order by C.numMail desc limit 5;

/** Question 7: Find the names of the 5 people that Hillary Clinton emailed the most. **/
select P.name, count(*) from Emails as E, Persons as P, EmailReceivers as R where R.EmailId=E.id and R.PersonID=P.id and E.SenderPersonId=80 group by P.name order by count(*) desc limit 5;
