-- using 1205002340 as a seed to the RNG
-- @(#)22.sql	2.1.8.1
-- TPC-H/TPC-R Global Sales Opportunity Query (Q22)
-- Functional Query Definition
-- Approved February 1998
START

EXPLAIN


select
	cntrycode,
	count(*) as numcust,
	sum(c_acctbal) as totacctbal
from
	(
		select
			substr(c_phone, 1, 2) as cntrycode,
			c_acctbal
		from
			customer
		where
			substr(c_phone, 1, 2) in
				('30', '29', '27', '18', '24', '15', '21')
			and c_acctbal > (
				select
					avg(c_acctbal)
				from
					customer
				where
					c_acctbal > 0.00
					and substr(c_phone, 1, 2) in
						('30', '29', '27', '18', '24', '15', '21')
			)
			and not exists (
				select
					*
				from
					orders
				where
					o_custkey = c_custkey
			)
	) as vip
group by
	cntrycode
order by
	cntrycode;
COMMIT;

