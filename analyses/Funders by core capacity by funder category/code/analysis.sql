as with top_level_stakeholder_ids as (
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
	s.cat_analysis AS "Funder analysis category",	
	c.fullname as "Core capacity",
	c.name as "Core capacity code",
	sum(sf.value) as "Total disbursed (nominal USD)"
from
	stakeholders s
join flows_to_stakeholder_origins_direct_credit ftsodc on
	ftsodc.stakeholder_id = s.id
join simple_flows sf on
	sf.sf_id = ftsodc.flow_id
join ccs_to_flows ccstf on
	ccstf.cc_flow_id = sf.sf_id
join core_capacities c on
	c.id = ccstf.cc_id
where
	sf.flow_type = 'disbursed_funds'::flow_types
	and sf.response_or_capacity = 'response'::response_or_capacity_vals
	and (s.id in (
	select
		top_level_stakeholder_ids.parent_id
	from
		top_level_stakeholder_ids))
group by
	c.fullname,
	c.name,
	s.cat_analysis 
order by
	c.fullname, (sum(sf.value)) desc
	)
select
	results."Funder analysis category",
	results."Core capacity",
	results."Core capacity code",
	results."Total disbursed (nominal USD)",
	round((results."Total disbursed (nominal USD)" / sum(results."Total disbursed (nominal USD)") over (order by results."Core capacity"))::numeric * 100.0, 2) as "Percentage of disbursements for this Core capacity"
from
	results
