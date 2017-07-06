module ApplicationHelper
    def bootstrap_class_for flash_type
        { success: "alert-success", danger: "alert-danger", alert: "alert-warning", notice:"alert-info"}[flash_type.to_sym]
    end   
end