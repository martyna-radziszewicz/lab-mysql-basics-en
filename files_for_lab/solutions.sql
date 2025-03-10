-- Query 1
-- Get the id values of the first 5 clients from district_id with a value equals to 1.

-- Expected result:

-- 2
-- 3
-- 22
-- 23
-- 28

select
client_id
from client
where district_id=1
limit 5;



-- Query 2
-- In the client table, get an id value of the last client where the district_id equals to 72.

-- Expected result:

-- 13576

select
max(client_id)
from client
where district_id = 72;

-- Query 3
-- Get the 3 lowest amounts in the loan table.

-- Expected result:

-- 4980
-- 5148
-- 7656
select
amount
from loan
order by 1 asc
limit 3;


-- Query 4
-- What are the possible values for status, ordered alphabetically in ascending order in the loan table?

-- Expected result:

-- A
-- B
-- C
-- D

select distinct
status
from loan
order by 1 asc;

-- Query 5
-- What is the loan_id of the highest payment received in the loan table?

-- Expected result:

-- 6415

select 
loan_id
from loan
order by payments desc
limit 1;

-- Query 6
-- What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount

-- Expected result:

-- #id     amount
-- 2	    80952
-- 19	    30276
-- 25	    30276
-- 37	    318480
-- 38	    110736

select
account_id,
amount
from loan
order by account_id asc
limit 5;

-- Query 7
-- What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?

-- Expected result:

-- 10954
-- 938
-- 10711
-- 1766
-- 10799

select
account_id,
amount
from loan
where duration = 60
order by amount asc
limit 5;

-- Query 8
-- What are the unique values of k_symbol in the order table?

-- Note: There shouldn't be a table name order, since order is reserved from the ORDER BY clause. You have to use backticks to escape the order table name.

-- Expected result:

-- LEASING
-- POJISTNE
-- SIPO
-- UVER

select
distinct k_symbol
from `order`;

-- Query 9
-- In the order table, what are the order_ids of the client with the account_id 34?

-- Expected result:

-- 29445
-- 29446
-- 29447

select
order_id
from `order`
where account_id = 34;

-- Query 10
-- In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?

-- Expected result:

-- 88
-- 90
-- 96
-- 97

select
account_id
from `order`
where order_id between 29540 and 29560
group by 1;

-- Query 11
-- In the order table, what are the individual amounts that were sent to (account_to) id 30067122?

-- Expected result:

-- 5123
select
distinct amount
from `order`
where account_to = 30067122;

-- Query 12
-- In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.

-- Expected result:

-- 3556468	981231	PRIJEM	78.6
-- 233254	981216	VYDAJ	600
-- 233104	981212	VYDAJ	1212
-- 233248	981211	VYDAJ	851
-- 233176	981207	VYDAJ	204
-- 3556467	981130	PRIJEM	75.1
-- 233395	981130	VYDAJ	14.6
-- 233103	981112	VYDAJ	1212
-- 233247	981111	VYDAJ	851
-- 233175	981107	VYDAJ	204

select
trans_id,
date,
type,
amount
from trans
where account_id = 793
order by date desc 
limit 10;

-- Query 13
-- In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.

-- Expected result:

-- 1	663
-- 2	46
-- 3	63
-- 4	50
-- 5	71
-- 6	53
-- 7	45
-- 8	69
-- 9	60

select
district_id,
count(*)
from client
where district_id < 10
group by 1
order by 1 asc;

-- Query 14
-- In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.

-- Expected result:

-- classic	659
-- junior	145
-- gold	88

select
type,
count(*)
from card
group by 1
order by 2 desc;

-- Query 15
-- Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.

-- Expected result:

-- 7542	590820
-- 8926	566640
-- 2335	541200
-- 817	    538500
-- 2936	504000
-- 7049	495180
-- 10451	482940
-- 6950	475680
-- 7966	473280
-- 339	    468060

select
account_id,
sum(amount)
from loan
group by 1
order by 2 desc
limit 10;

-- Query 16
-- In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.

-- Expected result:

-- 930906	1
-- 930803	1
-- 930728	1
-- 930711	1
-- 930705	1

select
date,
count(*)
from loan
where date < 930907
group by 1
order by 1 desc;

-- Query 17
-- In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.

-- Expected result:

-- 971206	24	1
-- 971206	36	1
-- 971208	12	3
-- 971209	12	1
-- 971209	24	1
-- 971210	12	1
-- 971211	24	1
-- 971211	48	1
-- 971213	24	1
-- 971220	36	1
-- 971221	36	1
-- 971224	60	1
-- 971225	24	1
-- 971225	60	1

select
date,
duration,
count(*)
from loan
where date between 971201 and 971231
group by 1,2
order by 1,2;

-- Query 18
-- In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.

-- Expected result:

-- 396	PRIJEM	1028138.6999740601
-- 396	VYDAJ	1485814.400024414


select
account_id,
type,
sum(amount) as total_amount
from trans
where account_id = 396
group by 1,2
order by 2 asc;