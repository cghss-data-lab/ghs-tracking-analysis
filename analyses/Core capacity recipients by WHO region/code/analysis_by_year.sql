WITH top_level_stakeholder_ids AS (
         SELECT DISTINCT children_to_parents_direct_credit.parent_id
           FROM children_to_parents_direct_credit
          WHERE NOT (children_to_parents_direct_credit.parent_id IN ( SELECT DISTINCT children_to_parents_direct_credit_1.child_id
                   FROM children_to_parents_direct_credit children_to_parents_direct_credit_1
                  WHERE children_to_parents_direct_credit_1.parent_id <> children_to_parents_direct_credit_1.child_id))
        ), results AS (
         SELECT s.region_who AS "Recipient WHO Region",
            c.fullname AS "Core capacity",
            c.name AS "Core capacity code",
            sum(sf.value) AS "Total disbursed (nominal USD)",
            sf.year as "Year"
           FROM stakeholders s
             JOIN flows_to_stakeholder_targets_direct_credit ftstdc ON ftstdc.stakeholder_id = s.id
             JOIN simple_flows sf ON sf.sf_id = ftstdc.flow_id
             JOIN ccs_to_flows ccstf ON ccstf.flow_id = sf.sf_id
             JOIN core_capacities c ON c.id = ccstf.cc_id
          WHERE sf.flow_type = 'disbursed_funds'::flow_types 
                 AND sf.response_or_capacity = 'capacity'
                 AND (s.id IN ( SELECT top_level_stakeholder_ids.parent_id
                   FROM top_level_stakeholder_ids))
          GROUP BY c.fullname, c.name, s.region_who, sf.year
          ORDER BY c.fullname, (sum(sf.value)) DESC
        )
 SELECT results."Recipient WHO Region",
    results."Core capacity",
    results."Core capacity code",
    results."Total disbursed (nominal USD)",
    results."Year"
   FROM results
