local Translations = {
    notify = {
        ["hud_settings_loaded"] = "HUD设置已加载！",
        ["hud_restart"] = "HUD正在重启！",
        ["hud_start"] = "HUD已启动！",
        ["hud_command_info"] = "该指令会重置你当前的HUD设置！",
        ["load_square_map"] = "方形地图加载中...",
        ["loaded_square_map"] = "方形地图加载完成！",
        ["load_circle_map"] = "圆形地图加载中...",
        ["loaded_circle_map"] = "圆形地图加载完成！",
        ["cinematic_on"] = "电影模式已开启！",
        ["cinematic_off"] = "电影模式已关闭！",
        ["engine_on"] = "引擎已启动！",
        ["engine_off"] = "引擎已熄火！",
        ["low_fuel"] = "燃油余量不足！",
        ["access_denied"] = "你没有权限进行此操作！",
        ["stress_gain"] = "压力值上升！",
        ["stress_removed"] = "压力已缓解！",
        ["seatbelt_on"] = "安全带已系上",
        ["seatbelt_off"] = "安全带已解开",
        ["cruise_on"] = "定速巡航已启动",
        ["cruise_off"] = "定速巡航已关闭"
    },
    info = {
        ["toggle_engine"] = "切换车辆引擎",
        ["open_menu"] = "打开设置菜单",
        ["check_cash_balance"] = "查看现金余额",
        ["check_bank_balance"] = "查看银行存款",
        ["toggle_dev_mode"] = "开启/关闭开发者模式",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
