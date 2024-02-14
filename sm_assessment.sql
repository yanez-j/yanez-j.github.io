select UserId,
  a.event_signup_created_at,
  a.event_id,
  a.event_name,
  a.event_sequence,
  b.user_created,
  b.is_subscribed

from (select signup_created_at as event_signup_created_at
      , ak_contact_id as UserId
      , event_id
      , event_name      from ak_in_person_events 
where signup_role = 'attendee') a
left join (
  select id as UserId
    creation_date as user_created,
    subscription_status = 'subscribed' as is_subscribed
  
  from ak_users 
  
  group by 1,2,3
  
  ) b using(UserId)
  
where user_id in (SELECT distinct ak_contact_id 
FROM ak_in_person_events 
WHERE event_name in ('MD Rally for Abortion Access'))
