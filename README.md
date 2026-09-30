# Cyclistic bike-share-analysis
 --------------------------------------------------------------------
## 📌 Project Overview
 --------------------------------------------------------------------
This project explores how riders use Cyclistic's bike-share service, with a specific focus on one core business question:

How do annual members and casual riders use Cyclistic bikes differently?

Rather than looking at growth through new customer acquisition, this analysis digs into the existing casual rider base — uncovering behavioral patterns (timing, duration, location, and bike preference) that can inform a targeted strategy to convert them into paying annual members.

 --------------------------------------------------------------------
## 🎯 Business Objective
 --------------------------------------------------------------------

Cyclistic's leadership has set a clear goal: grow the number of annual memberships. Since annual members are already known to be more profitable and reliable revenue sources than casual riders, this project focuses on the group most likely to convert — casual riders already engaging with the service — and identifies the usage patterns that can guide a data-informed marketing approach toward that conversion.

 --------------------------------------------------------------------
## 📸 Dashboard Preview
 --------------------------------------------------------------------
<img width="1920" height="1080" alt="2026-09-30 (14)" src="https://github.com/user-attachments/assets/721fefc1-e234-4346-abfd-0f7f4630a3a8" />
<img width="1920" height="1080" alt="2026-09-30 (10)" src="https://github.com/user-attachments/assets/568952c0-d5d6-4376-a46c-3a7d804a805c" />
<img width="1920" height="1080" alt="2026-09-30 (11)" src="https://github.com/user-attachments/assets/05782c8c-357e-402c-a8fc-8f934998f4ac" />
<img width="1920" height="1080" alt="2026-09-30 (12)" src="https://github.com/user-attachments/assets/bbe849aa-b262-43b8-a5d5-6afd49535c7f" />
<img width="1920" height="1080" alt="2026-09-30 (13)" src="https://github.com/user-attachments/assets/754683eb-1c48-4c3a-84e9-15a1e63b8420" />

 --------------------------------------------------------------------
## 🛠️ Tools used
 --------------------------------------------------------------------
* SQL Server Management Studio (SSMS)
   * Window functions (`OVER`, `PARTITION BY`)
   * Aggregations and `GROUP BY`
   * Conditional aggregation (`CASE WHEN`)
   * Common Table Expressions (CTEs)
* Tableau
   * Interactive dashboards
   * Dual-axis and combined charts
   * Reference lines and bands
   * Calculated fields and quick table calculations
   * Custom formatting and color-coded visualizations

 --------------------------------------------------------------------
## 🔄 Project Workflow
 --------------------------------------------------------------------

Raw Dataset  
↓  
Data Merging  
↓  
Data Cleaning & Feature Engineering  
↓  
SQL Business Analysis  
↓  
Visualization  
↓  
Findings  
↓  
Recommendations

 
 --------------------------------------------------------------------
## 📊 Key Insights
 --------------------------------------------------------------------
* Rides
  * Casual riders average almost double the trip length of members (20.45 min vs. 12.34 min)
  * Casual ride times are far more unpredictable — stddev (42.86) is more than double the average itself, pointing to a handful of very long outlier trips rather than a typical usage pattern
* When they ride — seasonal
   * Members ride fairly consistently year-round (60–83% share), while casual share more than doubles across the year (17% in winter to 40% in summer) — the seasonal surge is driven disproportionately by leisure riders, not commuters.
   * Ridership triples from winter to summer — Seasonality Index bottoms out around 25–30 in Dec/Jan and peaks near 165–168 in July
* When they ride — weekly
   * Members peak midweek (Tuesday–Wednesday, ~73% share)
   * casual riders peak on weekends (~45–48% share on Sat/Sun) — a clean commuter-vs-leisure split.
* When they ride — hourly
   * Members show two sharp commute peaks (~8 AM, ~5 PM)
   * casual riders show one smooth midday-to-evening rise — the clearest visual proof of the commuter-vs-leisure divide in the whole analysis.
* Where they ride
  * Zero overlap between top-10 stations by rider type. Casual riders cluster at lakefront/tourist landmarks (Navy Pier alone = 3.34% of all casual rides — over 6x the next station); members cluster at downtown business-district intersections with a much flatter distribution (top member station only 0.76%)

 --------------------------------------------------------------------
## 💡 Recommendations
 --------------------------------------------------------------------
 * Station‑Level Targeting
    * Focus conversion prompts at high‑traffic casual hubs such as Navy Pier, Millennium Park, and other top stations, rather than citywide. This ensures messaging reaches riders where casual usage is most concentrated
 * Seasonal Timing
    * Launch campaigns in spring (April–May), just before the summer surge. This captures casual riders as their activity begins to climb, maximizing impact before peak season.
 * Leisure‑Oriented Membership Tier
    * Create a special membership for riders who use bikes mainly for fun or weekend trips. Instead of focusing on commuter savings, highlight affordable options for longer, occasional leisure rides.
 * Cost Transparency Messaging
    * Trigger real‑time prompts after long rides:
“This ride cost $X — a membership would’ve been $Y.”  
Delivering this message at the pain point makes the value of membership tangible and immediate.
 * Prioritize Repeat Casuals
    * Concentrate efforts on repeat casual riders who appear across multiple months. These riders show higher conversion potential compared to one‑time tourists, who are less likely to adopt annual plans.

 --------------------------------------------------------------------
## 🎯 Skills Demonstrated
  --------------------------------------------------------------------
* Data Cleaning
* Exploratory Data Analysis
* SQL Server Management Studio (SSMS)
* Window Functions
* Data Aggregation
* Dashboard design
* Business Intelligence
* Business Recommendations

 --------------------------------------------------------------------
## 🎯 Final Takeaway
 --------------------------------------------------------------------
 
Casual riders use Cyclistic differently from members — they take longer, more variable rides, ride disproportionately on weekends and during summer, and concentrate heavily around recreational and landmark stations rather than the downtown hubs members favor. These consistent behavioral differences point to clear, targeted opportunities for converting casual riders into annual members — by season, by day, and by location — rather than relying on a single, broad campaign.

 --------------------------------------------------------------------
## 🔗 Link
 --------------------------------------------------------------------
 
https://public.tableau.com/views/Cyclisticanalysis_17907655768570/Overview?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link








  
