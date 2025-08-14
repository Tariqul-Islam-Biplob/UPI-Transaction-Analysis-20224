
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













