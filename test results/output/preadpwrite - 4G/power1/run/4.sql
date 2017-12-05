-- using 1205000951 as a seed to the RNG
-- @(#)4.sql	2.1.8.1
-- TPC-H/TPC-R Order Priority Checking Query (Q4)
-- Functional Query Definition
-- Approved February 1998
START

EXPLAIN


select
	o_orderpriority,
	count(*) as order_count
from
	orders
where
	o_orderdate >= date '1996-09-01'
	and o_orderdate < date '1996-09-01' + interval '3 months'
	and exists (
		select
			*
		from
			lineitem
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority
order by
	o_orderpriority;
COMMIT;

