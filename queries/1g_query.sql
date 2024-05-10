SELECT
    fid,
    fname,
    display_name,
    CASE WHEN display_name LIKE '%1g%' THEN 1 ELSE 0 END AS has_1g
FROM (
    SELECT
        profile.fid,
        profile.fname,
        profile.display_name,
        ROW_NUMBER() OVER (PARTITION BY profile.fid ORDER BY LENGTH(profile.verified_addresses) DESC NULLS LAST) AS rn
    FROM dune.neynar.dataset_farcaster_profile_with_addresses profile
) AS ranked_profiles
WHERE rn = 1;
