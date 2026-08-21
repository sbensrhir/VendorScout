-- ============================================================
-- VendorScout Content Calendar — Aug/Sep/Oct 2026 batch insert
-- Run this in the Supabase SQL Editor (project: modqzgdfrpypicyubpra)
--
-- Idempotent: safe to re-run. Adds any columns the front end
-- (docs/dashboard2/index.html, docs/content-strategy/index.html)
-- already reads/writes but that predate docs/dashboard2_setup.sql,
-- then replaces just the 14 planned rows for these dates.
-- ============================================================

-- 1) Columns the front end already depends on but the original
--    setup script never created.
alter table content_calendar add column if not exists sub_pillar text;
alter table content_calendar add column if not exists hook text;
alter table content_calendar add column if not exists linkedin_url text;

-- 2) Clear any prior planned rows for these 14 dates so this
--    script can be re-run safely without duplicating rows.
delete from content_calendar
where status = 'planned'
  and post_date in (
    '2026-08-25', '2026-08-27', '2026-09-01', '2026-09-03', '2026-09-08',
    '2026-09-10', '2026-09-15', '2026-09-17', '2026-09-22', '2026-09-24',
    '2026-09-29', '2026-10-01', '2026-10-06', '2026-10-08'
  );

-- 3) Insert the 14 planned posts.
--    sub_pillar values are prefixed to match SUBPILLARS keys used by
--    docs/content-strategy/index.html (p1a..p1c, p2a..p2d).
--    target_audience holds the CSV "Description" text — this is the
--    same column the content-strategy page's "Description" field
--    (t-desc) already reads/writes, it is not used for filtering.
insert into content_calendar
  (post_date, platform, topic, sub_pillar, target_audience, status, hook, impressions, likes, comments, generated_inbound)
values
  ('2026-08-25', 'LinkedIn',   'Adore Rewards: what a beauty loyalty program is actually worth',
    'p1a',
    'Costs Adore''s loyalty program against the real price gaps in the 20 Aug pull. 440k members, $20/$250, >half on app (ASX FY25). Argument: loyalty holds the basket, not the SKU. Pure retail, no Amazon.',
    'planned',
    'Adore Rewards pays $20 back for every $250 spent. On a $20 cleanser that''s $1.60 against a $6 price gap.',
    0, 0, 0, false),

  ('2026-08-27', 'Newsletter', 'The channel margin map',
    'p2b',
    'Gross-to-net by channel for an AU beauty brand. Sequencing conclusion falls out of the numbers. VERIFY every margin band against real terms or label as estimate.',
    'planned',
    'DTC, Amazon, Mecca and Chemist Warehouse do not make money the same way. Here is what each one actually returns.',
    0, 0, 0, false),

  ('2026-09-01', 'LinkedIn',   'SPF: the K-beauty battleground on Amazon AU',
    'p1c',
    'TGA regulation as the moat. Which Korean SPF lines list on Amazon AU and how. Category trend anchored to a listing/compliance implication.',
    'planned',
    'Australia consumes more sunscreen per head than any market on earth, and most Korean SPF cannot legally be sold here as sun protection.',
    0, 0, 0, false),

  ('2026-09-03', 'LinkedIn',   'Q4 deals and Beauty Page placements: how selection actually works',
    'p2a',
    'Selection criteria, submission windows, what gets a brand onto the Beauty Page. TIME-CRITICAL - do not slip past early September.',
    'planned',
    'Q4 deal submissions are decided months before the event. Most AU beauty brands find out afterwards.',
    0, 0, 0, false),

  ('2026-09-08', 'LinkedIn',   'Price reading 02: what moved in three weeks',
    'p1b',
    'Second reading of the 20 Aug basket. Separates promotional timing from structural pricing. Turns the snapshot into a series.',
    'planned',
    'Three weeks ago no retailer beat Amazon on any of eight skincare products. I checked the same basket again.',
    0, 0, 0, false),

  ('2026-09-10', 'Newsletter', 'Should a $5M AU beauty brand be on Amazon?',
    'p2d',
    'Full gross-to-net on one worked SKU: referral, FBA, storage, ads at realistic ACOS, returns, freight. Highest hire signal on the calendar.',
    'planned',
    'The honest answer is a framework, not a yes or no. Here is the one I would use.',
    0, 0, 0, false),

  ('2026-09-15', 'LinkedIn',   'Where TikTok demand lands in a market with no TikTok Shop',
    'p1c',
    'Biodance as case study: social-led, no local TikTok Shop, widest price dispersion in the Aug basket. AU-specific question nobody is asking.',
    'planned',
    'TikTok Shop is not live in Australia. The demand it creates still has to land somewhere.',
    0, 0, 0, false),

  ('2026-09-17', 'LinkedIn',   'Launching on Amazon without breaking your Chemist Warehouse relationship',
    'p2b',
    'Pricing discipline that protects both channels. Built on the Aug pricing data. Very high hire signal.',
    'planned',
    'The fear that stops most AU beauty brands launching on Amazon is the one nobody addresses directly.',
    0, 0, 0, false),

  ('2026-09-22', 'LinkedIn',   'The Australian Beauty Map - 2026 Edition',
    'p1b',
    'Single axis. No part number. Annual named asset, not a series episode. The one reach play in the block - post 9am.',
    'planned',
    'I mapped the Australian beauty retail landscape by price tier.',
    0, 0, 0, false),

  ('2026-09-24', 'LinkedIn',   'The first 90 days',
    'p2a',
    'What the algorithm rewards early: review velocity, conversion, availability, ad density. Concrete and actionable at the moment a brand needs help.',
    'planned',
    'The launch window most brands waste, and why it sets the next twelve months.',
    0, 0, 0, false),

  ('2026-09-29', 'LinkedIn',   'L''Oreal is adopting Korean skincare formulation logic',
    'p1c',
    'Weakest topic on the list - global trend, hard to make AU-specific. Swap for a spare if a better 1c emerges.',
    'planned',
    'When the largest beauty company in the world starts borrowing your playbook, the playbook stops being an advantage.',
    0, 0, 0, false),

  ('2026-10-01', 'LinkedIn',   'Annual Vendor Negotiation: walking in prepared',
    'p2c',
    'What Amazon actually wants going in, and how vendors should prepare. Most defensible topic on the calendar - nobody in AU can write it.',
    'planned',
    'Amazon has been preparing for your annual negotiation since the last one ended.',
    0, 0, 0, false),

  ('2026-10-06', 'LinkedIn',   'Who holds the buy box in Australian beauty',
    'p1b',
    'Anonymised buy-box scrape. 1P in Europe means Amazon owns the stock and can export it. Keep the brand unnamed.',
    'planned',
    'The largest seller of one global prestige makeup brand on Amazon AU is not a grey marketer. It is Amazon UK.',
    0, 0, 0, false),

  ('2026-10-08', 'Newsletter', 'From $100K to $1M on Amazon AU',
    'p2d',
    'Growth model by revenue stage. Aspirational and concrete - makes readers self-diagnose.',
    'planned',
    'What breaks at $100K is not what breaks at $500K.',
    0, 0, 0, false);

-- 4) Verify.
select post_date, platform, sub_pillar, status, topic
from content_calendar
where post_date between '2026-08-25' and '2026-10-08'
order by post_date;
