WITH top_level_stakeholder_ids AS (
         SELECT DISTINCT children_to_parents_direct_credit.parent_id
           FROM children_to_parents_direct_credit
          WHERE NOT (children_to_parents_direct_credit.parent_id IN ( SELECT DISTINCT children_to_parents_direct_credit_1.child_id
                   FROM children_to_parents_direct_credit children_to_parents_direct_credit_1
                  WHERE children_to_parents_direct_credit_1.parent_id <> children_to_parents_direct_credit_1.child_id))
        ), results AS (
         SELECT s.region_who AS "Funder WHO Region",
            c.fullname AS "Core capacity",
            c.name AS "Core capacity code",
            sum(sf.value) AS "Total disbursed (nominal USD)"
           FROM stakeholders s
             JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON ftsodc.stakeholder_id = s.id
             JOIN simple_flows sf ON sf.sf_id = ftsodc.flow_id
             JOIN ccs_to_flows ccstf ON ccstf.cc_flow_id = sf.sf_id
             JOIN core_capacities c ON c.id = ccstf.cc_id
          WHERE sf.flow_type = 'disbursed_funds'::flow_types AND sf.response_or_capacity = 'response'::response_or_capacity_vals AND (s.id IN ( SELECT top_level_stakeholder_ids.parent_id
                   FROM top_level_stakeholder_ids))
          GROUP BY c.fullname, c.name, s.region_who
          ORDER BY c.fullname, (sum(sf.value)) DESC
        )
 SELECT results."Funder WHO Region",
    results."Core capacity",
    results."Core capacity code",
    results."Total disbursed (nominal USD)",
    round((results."Total disbursed (nominal USD)" / sum(results."Total disbursed (nominal USD)") OVER (ORDER BY results."Core capacity"))::numeric * 100.0, 2) AS "Percentage of disbursements for this Core capacity"
   FROM results
