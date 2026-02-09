Config = {}

Config.Exports = {
    Progress = {
        CheckProgress = function()
            check = exports["qb-core"]:IsProgressbarActive()
            return check
        end
    },
    
    Cuff = {
        CuffCheck = function()
            check = exports["s4-cuffv3"]:HandCuffed()
            return check
        end
    },
    
}

Config.Stashs = {
	['geneldepo'] = {
		coord = vector3(-69.78, -1230.82, 28.94),
		maxweight = 30000,		-- ağırlık kg cinsinden
		slots = 200,			 	-- envanter slot sayısı
		label = 'all', 	-- (,.- boşluk vb. ve türkçe karakterler kullanmayın!)
		private = true,		-- true olursa kişiye özel depo olur
		job = 'all'				-- hangi meslek görecek
	},

}	