Config = {}

Config.Debug = false -- true = debug prints
Config.Language = 'pl' -- en / de / pl / fr / es / it / nl / ru / tr / ar

Config.canOpenTablet = function()
    local playerState = LocalPlayer.state
    if playerState.isDead or playerState.isCuffed then
        return false
    end
    
    return true
end

Config.Permissions = {
    ['doj'] = {
        ['0'] = {
            ['add_citizen_license'] = false, ['remove_citizen_license'] = false,
            ['change_citizen_picture'] = false, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = false, ['hire_player'] = false, ['promote_player'] = false,
            ['create_announcement'] = false, ['delete_announcement'] = false,
            ['change_company_picture'] = false,
            ['withdraw_money'] = false, ['deposit_money'] = false, ['account_balance'] = false,
            ['society_transactions'] = false, ['society_chart'] = false,
            ['charge_account'] = false, ['donate_account'] = false, ['save_account_note'] = false,
            ['create_inspection'] = false,
        },
        ['1'] = {
            ['add_citizen_license'] = false, ['remove_citizen_license'] = false,
            ['change_citizen_picture'] = false, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = false, ['hire_player'] = false, ['promote_player'] = false,
            ['create_announcement'] = false, ['delete_announcement'] = false,
            ['change_company_picture'] = false,
            ['withdraw_money'] = false, ['deposit_money'] = false, ['account_balance'] = false,
            ['society_transactions'] = false, ['society_chart'] = false,
            ['charge_account'] = false, ['donate_account'] = false, ['save_account_note'] = false,
            ['create_inspection'] = false,
        },
        ['2'] = {
            ['add_citizen_license'] = false, ['remove_citizen_license'] = false,
            ['change_citizen_picture'] = false, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = false, ['hire_player'] = false, ['promote_player'] = false,
            ['create_announcement'] = false, ['delete_announcement'] = false,
            ['change_company_picture'] = false,
            ['withdraw_money'] = false, ['deposit_money'] = false, ['account_balance'] = false,
            ['society_transactions'] = false, ['society_chart'] = false,
            ['charge_account'] = false, ['donate_account'] = false, ['save_account_note'] = false,
            ['create_inspection'] = false,
        },
        ['3'] = {
            ['add_citizen_license'] = true, ['remove_citizen_license'] = true,
            ['change_citizen_picture'] = true, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = false, ['hire_player'] = false, ['promote_player'] = false,
            ['create_announcement'] = true, ['delete_announcement'] = true,
            ['change_company_picture'] = false,
            ['withdraw_money'] = false, ['deposit_money'] = false, ['account_balance'] = false,
            ['society_transactions'] = false, ['society_chart'] = false,
            ['charge_account'] = false, ['donate_account'] = false, ['save_account_note'] = true,
            ['create_inspection'] = true,
        },
        ['4'] = {
            ['add_citizen_license'] = true, ['remove_citizen_license'] = true,
            ['change_citizen_picture'] = true, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = false, ['hire_player'] = false, ['promote_player'] = false,
            ['create_announcement'] = true, ['delete_announcement'] = true,
            ['change_company_picture'] = false,
            ['withdraw_money'] = false, ['deposit_money'] = false, ['account_balance'] = false,
            ['society_transactions'] = false, ['society_chart'] = false,
            ['charge_account'] = false, ['donate_account'] = false, ['save_account_note'] = true,
            ['create_inspection'] = true,
        },
        ['5'] = {
            ['add_citizen_license'] = true, ['remove_citizen_license'] = true,
            ['change_citizen_picture'] = true, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = false, ['hire_player'] = false, ['promote_player'] = false,
            ['create_announcement'] = true, ['delete_announcement'] = true,
            ['change_company_picture'] = false,
            ['withdraw_money'] = false, ['deposit_money'] = false, ['account_balance'] = false,
            ['society_transactions'] = false, ['society_chart'] = false,
            ['charge_account'] = false, ['donate_account'] = false, ['save_account_note'] = true,
            ['create_inspection'] = true,
        },
        ['6'] = {
            ['add_citizen_license'] = true, ['remove_citizen_license'] = true,
            ['change_citizen_picture'] = true, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = false, ['hire_player'] = false, ['promote_player'] = false,
            ['create_announcement'] = true, ['delete_announcement'] = true,
            ['change_company_picture'] = false,
            ['withdraw_money'] = false, ['deposit_money'] = false, ['account_balance'] = false,
            ['society_transactions'] = false, ['society_chart'] = false,
            ['charge_account'] = false, ['donate_account'] = false, ['save_account_note'] = true,
            ['create_inspection'] = true,
        },
        ['7'] = {
            ['add_citizen_license'] = true, ['remove_citizen_license'] = true,
            ['change_citizen_picture'] = true, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = false, ['hire_player'] = false, ['promote_player'] = false,
            ['create_announcement'] = true, ['delete_announcement'] = true,
            ['change_company_picture'] = false,
            ['withdraw_money'] = false, ['deposit_money'] = false, ['account_balance'] = true,
            ['society_transactions'] = false, ['society_chart'] = false,
            ['charge_account'] = true, ['donate_account'] = true, ['save_account_note'] = true,
            ['create_inspection'] = true,
        },
        ['8'] = {
            ['add_citizen_license'] = true, ['remove_citizen_license'] = true,
            ['change_citizen_picture'] = true, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = false, ['hire_player'] = false, ['promote_player'] = false,
            ['create_announcement'] = true, ['delete_announcement'] = true,
            ['change_company_picture'] = false,
            ['withdraw_money'] = false, ['deposit_money'] = false, ['account_balance'] = true,
            ['society_transactions'] = false, ['society_chart'] = false,
            ['charge_account'] = true, ['donate_account'] = true, ['save_account_note'] = true,
            ['create_inspection'] = true,
        },
        ['9'] = {
            ['add_citizen_license'] = true, ['remove_citizen_license'] = true,
            ['change_citizen_picture'] = true, ['add_citizen_note'] = true, ['delete_citizen_note'] = true,
            ['add_citizen_tag'] = true, ['delete_citizen_tag'] = true,
            ['fire_player'] = true, ['hire_player'] = true, ['promote_player'] = true,
            ['create_announcement'] = true, ['delete_announcement'] = true,
            ['change_company_picture'] = true,
            ['withdraw_money'] = true, ['deposit_money'] = true, ['account_balance'] = true,
            ['society_transactions'] = true, ['society_chart'] = true,
            ['charge_account'] = true, ['donate_account'] = true, ['save_account_note'] = true,
            ['create_inspection'] = true,
        },
    }
}