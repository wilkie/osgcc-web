require 'tzinfo'

class TimezoneFilter

  FILTER_LIST = [ 'Pacific/Kwajalein',
                  'Pacific/Midway',
                  'US/Hawaii',
                  'US/Alaska',
                  'US/Pacific',
                  'US/Mountain',
                  'US/Central',
                  'US/Eastern',
                  'Canada/Atlantic',
                  'Canada/Newfoundland',
                  'Brazil/East',
                  'Brazil/West',
                  'Atlantic/Azores',
                  'Europe/London',
                  'Europe/Paris',
                  'Europe/Kaliningrad',
                  'Asia/Baghdad',
                  'Asia/Tehran',
                  'Asia/Muscat',
                  'Asia/Kabul',
                  'Asia/Karachi',
                  'Asia/Calcutta',
                  'Asia/Kathmandu',
                  'Asia/Almaty',
                  'Asia/Bangkok',
                  'Asia/Hong_Kong',
                  'Asia/Tokyo',
                  'Australia/West',
                  'Australia/Adelaide',
                  'Australia/Sydney',
                  'Asia/Magadan',
                  'Pacific/Auckland' ]


  def self.unique
    TZInfo::Timezone.all.uniq{ |t| t.strftime("%Z") }
  end

  def self.small_list
    FILTER_LIST.map{ |t| TZInfo::Timezone.get(t) }
  end
end
