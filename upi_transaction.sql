
select * from upi_transaction

-- total transaction amount per sender bank 

select sender_bank , sum(amount_inr)  as total_transaction
from upi_transaction
group by sender_bank 
order by total_transaction desc 

-- Total number of transactions per state

select sender_state,sum(amount_inr) as total_per_state
from upi_transaction
group by sender_state
order by total_per_state desc

-- Total transaction amount per sender bank in a specific state

select sender_state,sender_bank,sum(amount_inr) total_amount
from upi_transaction
group by sender_bank,sender_state
order by total_amount desc

-- Average transaction amount for each transaction_type

select transaction_type, 
       round(avg(amount_inr),2) as average_per_transaction_type
from upi_transaction
group by transaction_type 
order by average_per_transaction_type desc

-- Maximum transaction amount done by each receiver_bank.

select receiver_bank,max(amount_inr) as max_per_bank
from upi_transaction
group by receiver_bank
order by max_per_bank desc

-- Rank Sender Banks by Total Transaction Amount

select sender_bank,
       sum(amount_inr) as total_trnasaction,
       rank() over(order by sum(amount_inr) desc) as rnk
from upi_transaction 
group by sender_bank


select sender_bank , sum(amount_inr),
        rank() over(order by sum(amount_inr) desc) as rank
from upi_transaction
where sender_state = 'Delhi'
group by sender_bank

--Find the average transaction amount for each transaction_type, 
          --and format the average amount as a float with 2 decimal places with rank

select transaction_type , round(avg(amount_inr),2),
         rank () over(order by avg(amount_inr) desc ) as rak
from upi_transaction
group by transaction_type

--Find the total transaction amount for each sender_bank and assign 
    -- a rank based on the total transaction amount in descending order.

select sender_bank,sum (amount_inr) as total_transaction,
        rank () over(order by sum(amount_inr) desc) as Rank
from upi_transaction
group by sender_bank

-- Find the total transaction amount for each sender_bank only for transactions in Delhi 
    -- and rank them based on the total amount in descending order.

select sender_bank,sum(amount_inr) as total_transaction,
        rank() over (order by sum(amount_inr) desc) as rank
from upi_transaction
where sender_state = 'Delhi'
group by sender_bank


--Find the total transaction amount for each transaction_type between 2024-05-01 and 2024-06-30, 
     -- and order them by total amount in descending order.

select transaction_type,
       sum(amount_inr) as total_amount 
from upi_transaction
where "timestamp" between '2024-05-01' and '2024-06-30'
group by transaction_type
order by total_amount desc;

--Find the top 3 sender banks with the highest total transaction amount between 2024-07-01 and 2024-07-31.

select sender_bank, sum(amount_inr) as total_transaction,
       rank () over (order by sum(amount_inr) desc) as rank 
from upi_transaction
where "timestamp" between '2024-07-01' and '2024-07-31' 
group by sender_bank
limit  3

--Find the maximum transaction amount and the minimum transaction amount for each transaction_type.

select transaction_type,
       min(amount_inr) as min_amount,
       max(amount_inr) as max_amount
from upi_transaction
group by transaction_type

--Find the total number of transactions made by each sender_bank in July 2024.

select sender_bank,count(*) as total_transaction
from upi_transaction
where "timestamp"  between'2024-07-1' and '2024-07-31' 
group by sender_bank
order by total_transaction desc

--Find the top 3 sender banks with the highest total transaction amount in July 2024.

select *
from (select sender_bank, sum(amount_inr) as total_amount,
       rank() over(order by sum(amount_inr) desc) as rnk
	   from upi_transaction
	   where "timestamp" between '2024-07-01' and '2024-07-31'
	   group by sender_bank
	   ) as t
where rnk <= 3

--Find the top transaction (highest amount) for each sender_bank in July 2024.

select *
from (select sender_bank,amount_inr,
         row_number() over (partition by sender_bank order by amount_inr desc) as rnk
	  from upi_transaction
      where "timestamp" between '2024-07-01' and '2024-07-31'
	 ) as t 
where rnk = 1 












