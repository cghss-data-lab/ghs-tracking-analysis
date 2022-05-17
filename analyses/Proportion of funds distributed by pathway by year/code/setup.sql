CREATE OR REPLACE VIEW public.pathway_proportions_over_time
AS WITH top_level_stakeholder_ids AS (
         SELECT DISTINCT children_to_parents_direct_credit.parent_id
           FROM children_to_parents_direct_credit
          WHERE NOT (children_to_parents_direct_credit.parent_id IN ( SELECT DISTINCT children_to_parents_direct_credit_1.child_id
                   FROM children_to_parents_direct_credit children_to_parents_direct_credit_1
                  WHERE children_to_parents_direct_credit_1.parent_id <> children_to_parents_direct_credit_1.child_id))
        ), results AS (
         SELECT s.cat_analysis AS "Funder category (country, international, or philanthropy)",
            target.cat_analysis AS "Recipient category (country, international, or philanthropy)",
            sf.year AS "Year",
            sum(sf.value) AS "Amount disbursed for year for capacity (nominal USD)"
           FROM stakeholders s
             JOIN flows_to_stakeholder_origins_direct_credit ftsodc ON ftsodc.stakeholder_id = s.id
             JOIN simple_flows sf ON sf.sf_id = ftsodc.flow_id
             JOIN flows_to_stakeholder_targets_direct_credit ftstdc ON ftstdc.flow_id = sf.sf_id
             JOIN stakeholders target ON target.id = ftstdc.stakeholder_id
          WHERE (target.id IN ( SELECT top_level_stakeholder_ids.parent_id
                   FROM top_level_stakeholder_ids)) AND (s.id IN ( SELECT top_level_stakeholder_ids.parent_id
                   FROM top_level_stakeholder_ids)) AND sf.flow_type = 'disbursed_funds'::flow_types AND sf.response_or_capacity = 'capacity'::response_or_capacity_vals AND sf.year >= 2014::double precision AND sf.year <= 3000::double precision
          GROUP BY s.cat_analysis, target.cat_analysis, sf.year
        ), testing AS (
         SELECT results."Funder category (country, international, or philanthropy)",
            results."Recipient category (country, international, or philanthropy)",
            results."Year",
            results."Amount disbursed for year for capacity (nominal USD)",
            sum(results."Amount disbursed for year for capacity (nominal USD)") OVER (PARTITION BY results."Funder category (country, international, or philanthropy)", results."Recipient category (country, international, or philanthropy)" ORDER BY results."Funder category (country, international, or philanthropy)", results."Recipient category (country, international, or philanthropy)" DESC) AS "Total disbursed post-2013 for capacity (nominal USD)"
           FROM results
          ORDER BY results."Funder category (country, international, or philanthropy)", results."Recipient category (country, international, or philanthropy)", results."Year"
        )
 SELECT testing."Funder category (country, international, or philanthropy)",
    testing."Recipient category (country, international, or philanthropy)",
    testing."Year",
    testing."Amount disbursed for year for capacity (nominal USD)",
    testing."Total disbursed post-2013 for capacity (nominal USD)",
    round((testing."Amount disbursed for year for capacity (nominal USD)" / testing."Total disbursed post-2013 for capacity (nominal USD)")::numeric * 100.0, 2) AS "Percentage of total distributed to this pathway in year"
   FROM testing;
