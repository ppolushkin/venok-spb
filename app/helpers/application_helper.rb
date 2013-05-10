# coding: utf-8

module ApplicationHelper

  def store_link(name, url, action)
    link_to(name, url, setup_store_active_tab(action))
  end

  def setup_store_active_tab(action)
    {:class => "active"} if (current_page?(:controller=>:store, :action=>action))
  end

  def page_ref_link(name, page_ref, root = false)
    link_to(name, '/'+page_ref, setup_active_tab(page_ref, root))
  end

  def setup_active_tab(page_ref, root)
    if(root && current_page?('/'))
      return {:class => "active"}
    end
    if (current_page?(:controller=>"pages", :action=>"show_by_page_ref", :page_ref=>page_ref))
      {:class => "active"}
    end
  end

  def print_notice(notice)
    if(notice)
      "<p id=\"notice\">" + notice + "</p>"
    else
      ''
    end
  end

end
