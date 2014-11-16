module MainsHelper

	#計算離發表留言多久了
	def time_between(time)
		pitch=(Time.now - time).to_i
		if pitch < 60
			return "#{pitch} 秒前"
		elsif pitch>=60 && pitch<3600
			return "#{pitch/60} 分鐘前"
		elsif pitch>=3600 && pitch<86400
			return "#{pitch/3600} 小時前"
		elsif pitch>=86400 && pitch<31536000
			return "#{pitch/86400} 天前"
		else
			return "#{pitch/31536000} 年前"
		end
	end
end
