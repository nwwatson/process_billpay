User.create!(
  email: 'admin@test.com',
  first_name: 'System',
  last_name: 'Administrator',
  password: 'changeME123!',
  password_confirmation: 'changeME123!',
  admin: true
)

Fund.create(
  name: 'General Fund',
  planning_center_id: 185489,
  bluepay_category: 'General Fund-401101'
)

Fund.create(
  name: 'Building Fund',
  planning_center_id: 186827,
  bluepay_category: 'Building Fund-402101'
)

Fund.create(
  name: 'Branching Out',
  planning_center_id: 186831,
  bluepay_category: 'Branching Out-Phase #1 -230023'
)

Fund.create(
  name: 'Strengthening Our Future',
  planning_center_id: 186830,
  bluepay_category: 'Strengthen Our Future-230016'
)

Fund.create(
  name: 'Food Pantry',
  planning_center_id: 186865,
  bluepay_category: 'Food Pantry-230003'
)

Fund.create(
  name: 'Missions General',
  planning_center_id: 186844,
  bluepay_category: 'Missions-230003'
)

Fund.create(
  name: 'Loose Cash',
  planning_center_id: 186828,
)

Fund.create(
  name: 'Community Care',
  planning_center_id: 186854,
)

Fund.create(
  name: 'Outreach General Care',
  planning_center_id: 186861,
)

Fund.create(
  name: 'Fellowship Events',
  planning_center_id: 186860,
  bluepay_category: 'Fellowship Events-510103'
)

Fund.create(
  name: 'Class Curriculum',
  planning_center_id: 186867,
)

Fund.create(
  name: 'General Fellowship',
  planning_center_id: 186860,
)

Fund.create(
  name: 'Worship General Expense',
  planning_center_id: 187766,
)

Fund.create(
  name: 'Courtney Joseph Mission Support',
  planning_center_id: 189674,
)

Fund.create(
  name: 'CCA Fees',
  planning_center_id: 186858,
)

Fund.create(
  name: 'Gablers Mission Support',
  planning_center_id: 186864,
)

Fund.create(
  name: 'Memorial Garden Deposits',
  planning_center_id: 186863,
)

Fund.create(
  name: 'Club Crossroads',
  planning_center_id: 186862,
)

Fund.create(
  name: 'Funerals',
  planning_center_id: 186859,
)

Fund.create(
  name: 'Student Ministry Activities',
  planning_center_id: 186855,
)

Fund.create(
  name: 'Wedding Fees',
  planning_center_id: 186852,
)

Fund.create(
  name: 'Pastors Descretionary',
  planning_center_id: 186851,
)

Fund.create(
  name: 'Music/Worship Reserve',
  planning_center_id: 186849,
)

Fund.create(
  name: 'Sunday School Offering',
  planning_center_id: 186846,
)

Fund.create(
  name: 'Student Ministry General',
  planning_center_id: 186848,
)

SyncPcPeople.call