# -------------------------------------------------------------------------- #
# Copyright 2002-2012, OpenNebula Project Leads (OpenNebula.org)             #
#                                                                            #
# Licensed under the Apache License, Version 2.0 (the "License"); you may    #
# not use this file except in compliance with the License. You may obtain    #
# a copy of the License at                                                   #
#                                                                            #
# http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                            #
# Unless required by applicable law or agreed to in writing, software        #
# distributed under the License is distributed on an "AS IS" BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
# See the License for the specific language governing permissions and        #
# limitations under the License.                                             #
#--------------------------------------------------------------------------- #

require 'OpenNebula/Pool'

module OpenNebula

    # All subclasses must define the DocumentPool::TYPE constant
    # and the factory method.
    #
    # @example
    #   require 'OpenNebula/DocumentPool'
    #
    #   module OpenNebula
    #       class CustomObjectPool < DocumentPool
    #
    #           DocumentPool::TYPE = 400
    #
    #           def factory(element_xml)
    #               OpenNebula::CustomObject.new(element_xml, @client)
    #           end
    #       end
    #   end
    class DocumentPool < Pool

        #######################################################################
        # Constants and Class attribute accessors
        #######################################################################

        DOCUMENT_POOL_METHODS = {
            :info => "documentpool.info"
        }

        #######################################################################
        # Class constructor & Pool Methods
        #######################################################################

        # Class constructor
        #
        # @param [OpenNebula::Client] client the xml-rpc client
        # @param [Integer] user_id the filter flag, see
        #   http://opennebula.org/documentation:rel3.6:api
        #
        # @return [DocumentPool] the new object
        def initialize(client, user_id=-1)
            super('DOCUMENT_POOL','DOCUMENT',client)

            @user_id  = user_id
        end

        #######################################################################
        # XML-RPC Methods for the Document Object
        #######################################################################

        # Retrieves all or part of the Documents in the pool.
        #
        # @return [nil, OpenNebula::Error] nil in case of success, Error
        #   otherwise
        def info(*args)
            case args.size
                when 0
                    info_filter(DOCUMENT_POOL_METHODS[:info],@user_id,-1,-1, TYPE)
                when 3
                    info_filter(DOCUMENT_POOL_METHODS[:info],args[0],args[1],args[2], TYPE)
            end
        end

        def info_all()
            return super(DOCUMENT_POOL_METHODS[:info], TYPE)
        end

        def info_mine()
            return super(DOCUMENT_POOL_METHODS[:info], TYPE)
        end

        def info_group()
            return super(DOCUMENT_POOL_METHODS[:info], TYPE)
        end
    end
end
