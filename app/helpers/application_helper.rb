# coding: utf-8

module ApplicationHelper

  def print_notice(notice)
    if notice
      "<div id=\"notice\">" + notice + "</div>"
    else
      ''
    end
  end

end
