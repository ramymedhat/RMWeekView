Pod::Spec.new do |s|
  s.name         = 'RMWeekView'
  s.version      = '0.1.0'
  s.summary      = 'Week View Control'
  s.author = {
    'Ramy Medhat' => 'ramymedhat@gmail.com'
  }
  non_arc_files = 'RMWeekView/Source/NSDate-Utilities.m',
    'RMWeekView/Source/NSDate+Helper.m',
    'RMWeekView/Source/OCCalendarView.m',
    'RMWeekView/Source/OCCalendarViewController.m',
    'RMWeekView/Source/OCDaysView.m',
    'RMWeekView/Source/OCSelectionView.m'
  s.source = {
    :git => 'https://github.com/ramymedhat/RMWeekView.git',
    :tag => '0.1.0'
  }
  s.source_files = 'RMWeekView/Source/*.{h,m}'
  s.requires_arc = true
  s.subspec 'no-arc' do |sna|
    sna.requires_arc = false
    sna.source_files = non_arc_files
  end
end
