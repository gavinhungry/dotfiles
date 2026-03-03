[animation]
s0_open_effects = animationsim:Fly In 3;animationsim:Fly In 2;animationsim:Fly In;animationsim:Fly In;animation:Glide 2;animation:Glide 2;animation:Fade;animation:Fade;animationsim:Fly In;
s0_open_durations = 150;150;150;150;400;200;75;75;500;
s0_open_matches = class=Dunst;role=volatile-level;role=volatile | role=xfce4-datetime-plugin-calendar;class=Rofi;class=zenity;(type=Normal | Dialog | ModalDialog | Unknown) & !(class=screenshooter) & !(class=xsecurelock);(type=Menu | PopupMenu | DropdownMenu | Combo);(type=Tooltip | Notification | Utility) & !(name=compiz) & !(title=notify-osd);class=Xfce4-panel & role=Panel;
s0_open_options = ;;;;;;;;;
s0_close_effects = animationsim:Fly In 3;animationsim:Fly In 2;animationsim:Fly In;animationsim:Fly In;animation:Glide 2;animation:Fade;animation:Fade;animationsim:Fly In;
s0_close_durations = 150;150;150;150;200;75;75;500;
s0_close_matches = class=Dunst;role=volatile-level;role=volatile | role=xfce4-datetime-plugin-calendar;class=Rofi;(type=Normal | Dialog | ModalDialog | Unknown) & !(class=screenshooter) & !(class=xsecurelock);(type=Menu | PopupMenu | DropdownMenu | Combo);(type=Tooltip | Notification | Utility) & !(name=compiz) & !(title=notify-osd);class=Xfce4-panel & role=Panel;
s0_close_options = ;;;;;;;;
s0_minimize_effects = animation:Zoom;
s0_minimize_durations = 350;
s0_minimize_matches = (type=Normal | Dialog | ModalDialog | Unknown) & !(name=gnome-screensaver);
s0_unminimize_effects = animation:Zoom;
s0_unminimize_durations = 350;
s0_unminimize_matches = (type=Normal | Dialog | ModalDialog | Unknown) & !(name=gnome-screensaver);
s0_shade_effects = 
s0_shade_durations = 
s0_shade_matches = 
s0_shade_options = 
s0_glide2_away_angle = 0.000000
s0_zoom_from_center = 2

[animationaddon]
s0_beam_color = #7f7f7fff
s0_fire_color = #ff3305ff

[animationplus]
s0_bonanza_color = #ff3305ff

[animationsim]
s0_flyin_distance = 16.000000
s0_flyin2_direction = 2
s0_flyin2_distance = 16.000000
s0_flyin3_direction = 3
s0_flyin3_distance = 16.000000

[blur]
s0_focus_blur_match = any
s0_alpha_blur_match = class=Dunst | class=Rofi | class=Roxterm | class=Xfce4-panel | role=volatile-level | type=Tooltip | type=PopupMenu | type=Combo | type=DropdownMenu | type=Utility
s0_filter = 1
s0_gaussian_radius = 80
s0_mipmap_lod = 5.000000
s0_independent_tex = true

[composite]
s0_detect_refresh_rate = false
s0_refresh_rate = 144

[core]
s0_active_plugins = core;composite;opengl;compiztoolbox;imgjpeg;maximumize;decor;extrawm;grid;imgpng;imgsvg;mousepoll;move;place;put;regex;resize;text;vpswitch;wall;winrules;animation;animationaddon;animationsim;blur;commands;ezoom;workarounds;
s0_audible_bell = false
s0_outputs = 3440x1440+0+0;
s0_raise_window_button = Disabled
s0_lower_window_button = Disabled
s0_minimize_window_key = Disabled
s0_maximize_window_key = Disabled
s0_unmaximize_window_key = Disabled
s0_show_desktop_key = Disabled
s0_toggle_window_shaded_key = Disabled
s0_hsize = 3

[cubeaddon]
s0_ground_color1 = #b3b3b3cc
s0_ground_color2 = #b3b3b300

[decor]
s0_command = exec /usr/bin/emerald
s0_decoration_match = (!(class=steam_app_*) & !(name=projectM-pulseaudio) & !(class=firefox & role=PictureInPicture)
s0_shadow_match = 

[expo]
s0_ground_color1 = #b3b3b3cc
s0_ground_color2 = #b3b3b300

[extrawm]
s0_toggle_fullscreen_key = F11

[ezoom]
s0_zoom_in_button = Disabled
s0_zoom_out_button = Disabled
s0_zoom_box_outline_color = #121212e7
s0_zoom_box_fill_color = #2323237f
s0_zoom_smoothing = 0
s0_zoom_specific_1_key = <Super>q
s0_fit_to_window_key = Disabled
s0_minimum_zoom = 0.010000
s0_zoom_mode = 1
s0_scale_mouse_dynamic = false
s0_scale_mouse_static = 0.100000
s0_follow_focus = false
s0_speed = 50.000000
s0_timestep = 0.750000

[firepaint]
s0_fire_color = #ff3305ff

[freewins]
s0_circle_color = #54befb80
s0_line_color = #1800ffff
s0_cross_line_color = #1800ffff

[grid]
s0_put_center_key = Disabled
s0_put_left_key = Disabled
s0_put_right_key = Disabled
s0_put_top_key = Disabled
s0_put_bottom_key = Disabled
s0_put_topleft_key = Disabled
s0_put_topright_key = Disabled
s0_put_bottomleft_key = Disabled
s0_put_bottomright_key = Disabled
s0_put_maximize_key = Disabled
s0_put_restore_key = Disabled
s0_left_maximize = Disabled
s0_right_maximize = Disabled
s0_top_left_corner_action = 7
s0_top_edge_action = 8
s0_top_right_corner_action = 9
s0_bottom_left_corner_action = 1
s0_bottom_edge_action = 2
s0_bottom_right_corner_action = 3
s0_top_edge_threshold = 15
s0_bottom_edge_threshold = 15
s0_draw_indicator = false
s0_draw_stretched_window = false
s0_animation_duration = 0
s0_outline_color = #121212e7
s0_fill_color = #2323237f

[maximumize]
s0_trigger_max_key = Disabled
s0_trigger_min_key = Disabled

[mblur]
s0_mode = 1

[move]
s0_initiate_button = <Super>Button1
s0_initiate_key = Disabled

[obs]
s0_opacity_increase_key = <Shift><Alt>braceright
s0_opacity_increase_button = Disabled
s0_opacity_decrease_key = <Shift><Alt>braceleft
s0_opacity_decrease_button = Disabled
s0_default_opacity_spawn_value = 50
s0_opacity_values = 0;
s0_brightness_values = 0;
s0_saturation_values = 0;

[opengl]
s0_texture_filter = 0
s0_lighting = true

[place]
s0_position_matches = class=Com.yubico.yubioath;class=Gcr-prompter | class=Signal;type=Normal & class=1Password;type=Normal & class=Rhythmbox;name=outlook.office.com;name=teams.microsoft.com;role=volatile & !(role=volatile-level);role=xfce4-datetime-plugin-calendar;role=volatile & !(role=volatile-level);role=xfce4-datetime-plugin-calendar;
s0_position_x_values = 2979;3440;3440;3440;0;3440;3199;3231;3199;3231;
s0_position_y_values = 67;0;0;1440;0;0;67;67;1403;1279;
s0_position_constrain_workarea = false;true;true;true;true;true;false;false;false;false;
s0_mode_matches = class=Hashbrowns;
s0_mode_modes = 1;

[put]
s0_put_center_key = <Super>backslash
s0_put_left_key = <Super>bracketleft
s0_put_right_key = <Super>bracketright
s0_put_top_key = <Super>Home
s0_put_bottom_key = <Super>End
s0_put_topleft_key = <Super>Insert
s0_put_topright_key = <Super>Prior
s0_put_bottomleft_key = <Super>Delete
s0_put_bottomright_key = <Super>Next
s0_put_restore_key = Disabled
s0_put_pointer_key = Disabled
s0_pad_left = 16
s0_pad_right = 16
s0_pad_top = 16
s0_pad_bottom = 16
s0_avoid_offscreen = true
s0_speed = 7.500000
s0_timestep = 0.100000

[resize]
s0_initiate_button = <Super>Button3
s0_initiate_key = Disabled
s0_mode = 2
s0_increase_border_contrast = false
s0_border_color = #121212e7
s0_fill_color = #2323237f
s0_centered_modifier = 

[resizeinfo]
s0_gradient_1 = #cccce6cc
s0_gradient_2 = #f3f3f3cc
s0_gradient_3 = #d9d9d9cc
s0_outline_color = #e6e6e6ff

[ring]
s0_next_key = Disabled
s0_prev_key = Disabled
s0_next_all_key = Disabled
s0_prev_all_key = Disabled

[screenshot]
s0_selection_outline_color = #2f2f4f9f
s0_selection_fill_color = #2f2f4f4f

[shift]
s0_initiate_key = Disabled
s0_next_key = Disabled
s0_prev_key = Disabled
s0_next_all_key = Disabled
s0_prev_all_key = Disabled
s0_minimized = false
s0_speed = 3.000000
s0_shift_speed = 5.000000
s0_timestep = 4.000000
s0_size = 65
s0_background_intensity = 0.000000
s0_hide_all = true
s0_reflection = false
s0_ground_color1 = #b3b3b3cc
s0_ground_color2 = #b3b3b300
s0_overlay_icon = 0
s0_mipmaps = true
s0_multioutput_mode = 1
s0_cover_angle = 0.000000
s0_cover_max_visible_windows = 1
s0_window_title = false

[showmouse]
s0_color = #ffdf3fff

[snap]
s0_avoid_snap = 
s0_resistance_distance = 24

[staticswitcher]
s0_next_key = Disabled
s0_prev_key = Disabled
s0_next_all_key = Disabled
s0_prev_all_key = Disabled
s0_background_color = #333333d9

[switcher]
s0_next_key = Disabled
s0_prev_key = Disabled
s0_next_all_key = Disabled
s0_prev_all_key = Disabled
s0_next_no_popup_key = <Alt>Tab
s0_prev_no_popup_key = <Shift><Alt>Tab
s0_window_match = (Toolbar | Utility | Dialog | Normal | Unknown)
s0_mipmap = false
s0_brightness = 100
s0_opacity = 100
s0_focus_on_switch = true
s0_zoom = 0.000000
s0_icon = false
s0_minimized = false
s0_background_color = #333333d9

[thumbnail]
s0_thumb_color = #0000007f
s0_font_background_color = #0000007f

[vpswitch]
s0_switch_to_1_key = <Super>1
s0_switch_to_2_key = <Super>2
s0_switch_to_3_key = <Super>3
s0_switch_to_4_key = <Super>4
s0_switch_to_5_key = <Super>5
s0_next_button = Disabled
s0_prev_button = Disabled
s0_initiate_button = Disabled

[wall]
s0_show_switcher = false
s0_outline_color = #333333d9
s0_background_gradient_base_color = #cccce6d9
s0_background_gradient_highlight_color = #f3f3ffd9
s0_background_gradient_shadow_color = #f3f3ffd9
s0_thumb_gradient_base_color = #33333359
s0_thumb_gradient_highlight_color = #3f3f3f3f
s0_thumb_highlight_gradient_base_color = #fffffff3
s0_thumb_highlight_gradient_shadow_color = #dfdfdfa6
s0_arrow_base_color = #e6e6e6d9
s0_arrow_shadow_color = #dcdcdcd9
s0_slide_duration = 0.000000
s0_left_key = <Super>Left
s0_right_key = <Super>Right
s0_up_key = Disabled
s0_down_key = Disabled
s0_left_window_key = <Super>grave
s0_right_window_key = <Super>Tab
s0_up_window_key = Disabled
s0_down_window_key = Disabled
s0_flip_left_edge = 
s0_flip_right_edge = 
s0_flip_up_edge = 
s0_flip_down_edge = 
s0_edgeflip_move = false

[winrules]
s0_skiptaskbar_match = (class=firefox & role=PictureInPicture) | class=projectM-pulseaudio | class=Com.yubico.yubioath
s0_above_match = role=volatile | role=volatile-level | role=xfce4-datetime-plugin-calendar
s0_sticky_match = (class=firefox & role=PictureInPicture) | role=volatile | role=volatile-level
s0_no_move_match = role=volatile | role=volatile-level | role=xfce4-datetime-plugin-calendar | class=Com.yubico.xyubioath
s0_no_resize_match = class=Com.yubico.yubioath
s0_no_minimize_match = class=Com.yubico.yubioath
s0_no_maximize_match = class=Com.yubico.yubioath
s0_no_focus_match = role=volatile | role=volatile-level
s0_size_matches = class=Com.yubico.yubioath;
s0_size_width_values = 460;
s0_size_height_values = 1372;

[wobbly]
s0_snap_inverted = true

[workarounds]
s0_firefox_menu_fix = true
s0_ooo_menu_fix = false
s0_java_fix = false
s0_java_taskbar_fix = false
s0_force_glx_sync = true
s0_initial_damage_complete_redraw = false
s0_force_swap_buffers = true
s0_sticky_alldesktops = true

[workspacenames]
s0_viewports = 
s0_names = 

