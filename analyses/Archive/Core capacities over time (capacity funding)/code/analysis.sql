with top_level_stakeholder_ids as (
select
	distinct children_to_parents_direct_credit.parent_id
from
	children_to_parents_direct_credit
where
	not (children_to_parents_direct_credit.parent_id in (
	select
		distinct children_to_parents_direct_credit_1.child_id
	from
		children_to_parents_direct_credit children_to_parents_direct_credit_1
	where
		children_to_parents_direct_credit_1.parent_id <> children_to_parents_direct_credit_1.child_id))
        ),
results as (
select
	c.fullname as "Core capacity",
	c.name as "Core capacity code",	
	sf.year as "Year",
	sum(sf.value) as "Amount disbursed for year for capacity (nominal USD)"
from
	stakeholders s
join flows_to_stakeholder_origins_direct_credit ftsodc on
	ftsodc.stakeholder_id = s.id
join simple_flows sf on
	sf.sf_id = ftsodc.flow_id
join ccs_to_flows ccstf on
	ccstf.flow_id = sf.sf_id
join core_capacities c on
	c.id = ccstf.cc_id
where
	sf.flow_type = 'disbursed_funds'::flow_types
	and sf.response_or_capacity = 'capacity'::response_or_capacity_vals
group by
	c.fullname,
	c.name,
	sf.year),
testing as (
select
	results."Core capacity",
	results."Core capacity code",
	results."Year",
	results."Amount disbursed for year for capacity (nominal USD)",
	sum(results."Amount disbursed for year for capacity (nominal USD)") over (partition by results."Core capacity" order by results."Core capacity" desc) as "Total disbursed post-2013 for capacity (nominal USD)"
from
results
order by
results."Core capacity",
results."Year")
select
	testing."Core capacity",
	testing."Core capacity code",
	testing."Year",
	testing."Amount disbursed for year for capacity (nominal USD)",
	testing."Total disbursed post-2013 for capacity (nominal USD)",
	round((testing."Amount disbursed for year for capacity (nominal USD)" / testing."Total disbursed post-2013 for capacity (nominal USD)")::numeric * 100.0, 2) as "Percentage of total distributed to this capacity in year"
from
	testing
