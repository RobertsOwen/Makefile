# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: oroberts <oroberts@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/10 14:33:51 by oroberts          #+#    #+#              #
#    Updated: 2020/11/30 17:02:38 by oroberts         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			=	TO_CHANGE
FILE_EXTENSION	=	TO_CHANGE


##############################
###          SRCS          ###
##############################
SRCS_DIR		=	srcs/
SRCS			=	main.c \
					pouet.c \
					other.c \
					sub/sub.c
vpath				%.$(FILE_EXTENSION) $(SRCS_DIR)

##############################
###        HEADERS         ###
##############################
HEADERS_DIR		=	headers/
HEADERS			=	head.h \
					other.h
vpath				%.h $(HEADERS_DIR)

##############################
###          OBJS          ###
##############################
OBJS_DIR		=	.objs/
OBJS			=	$(addprefix $(OBJS_DIR)/, $(SRCS:.c=.o))
vpath				%.o $(OBJS_DIR)

##############################
###      DEPENDENCIES      ###
##############################
DEP_DIR			=	.dependencies/
DEP				=	$(addprefix $(DEP_DIR)/, $(SRCS:.c=.d))
vpath				%.d $(DEP_DIR)


##############################
###      COMPILATION       ###
##############################
CC				=	TO_CHANGE
CFLAGS			=	-Wall -Wextra -Werror
DEPFLAGS		=	-MT $@ -MMD -MP -MF $(DEP_DIR)/$*.d
SHELL			=	/bin/bash




##############################
###         RULES          ###
##############################

all				:	$(OBJS_DIR) $(DEP_DIR) $(NAME)

$(NAME)			:	$(OBJS)
					$(CC) $(CFLAGS) $(DEPFLAGS) $(OBJS) -o $(NAME)

$(OBJS_DIR)/%.o	:	%.c | $(DEP_DIR)/%.d
					$(CC) $(CFLAGS) $(DEPFLAGS) -o $@ -c $<

$(OBJS_DIR)		:
					mkdir -p $(OBJS_DIR)
					find srcs/* -type d
					find srcs/* -type d | sed 's^$(SRCS_DIR)^$(OBJS_DIR)^g' | xargs mkdir -p


$(DEP_DIR)		:
					mkdir -p $(DEP_DIR)
					find srcs/* -type d | sed 's^$(SRCS_DIR)^$(DEP_DIR)^g' | xargs mkdir -p

clean			:
					rm -rf $(OBJS_DIR)

fclean			:	clean
					rm -rf $(NAME)

dclean			:
					rm -rf $(DEP_DIR)

re				:	fclean	all

remake			:	fclean dclean
					sed -i "s/^SRCS\t.*/SRCS\t\t\t=\t$$(echo $$(ls $(SRCS_DIR) | grep .cpp))/" Makefile
					sed -i "s/^HEADERS\t.*/HEADERS\t\t\t=\t$$(echo $$(ls $(HEADERS_DIR) | grep .hpp))/" Makefile

.PHONY			:	all clean fclean dclean re remake

$(DEP)			:
include $(wildcard $(DEP))