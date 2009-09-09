#
# Cookbook Name:: apache2
# Recipe:: dav_svn 
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "libapache2-svn"

apache_module "dav_svn"

directory "/srv/svn" do
  recursive true
  owner "www-data"
  group "www-data"
  mode "0755"
end

web_app "subversion" do
  template "subversion.conf.erb"
  server_name "svn.#{node[:domain]}"
end

execute "svnadmin create repo" do
  command "svnadmin create /srv/svn/repo"
  creates "/srv/svn/repo"
  user "www-data"
  group "www-data"
end

execute "create htpasswd file" do
  command "htpasswd -scb /srv/svn/htpasswd subversion subversion"
end
